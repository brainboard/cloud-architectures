resource "azurerm_resource_group" "resource-group_hub" {
  tags     = merge(var.tags, {})
  name     = var.rg_hub_name
  location = var.location
}

resource "azurerm_virtual_network" "virtual_network_hub" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group_hub.name
  name                = "vnet_hub"
  location            = var.location

  address_space = [
    var.vnet_hub_addr_space,
  ]
}

resource "azurerm_virtual_network_peering" "virtual_network_peering" {
  virtual_network_name         = azurerm_virtual_network.virtual_network_hub.name
  resource_group_name          = azurerm_resource_group.resource-group_hub.name
  remote_virtual_network_id    = azurerm_virtual_network.virtual_network_spoke.id
  name                         = "peerhubtospoke"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_subnet" "subnet_firewall" {
  virtual_network_name = azurerm_virtual_network.virtual_network_hub.name
  resource_group_name  = azurerm_resource_group.resource-group_hub.name
  name                 = "AzureFirewallSubnet"

  address_prefixes = [
    var.snet_firewall_addr_space,
  ]
}

resource "azurerm_subnet" "subnet_jumphost" {
  virtual_network_name = azurerm_virtual_network.virtual_network_hub.name
  resource_group_name  = azurerm_resource_group.resource-group_hub.name
  name                 = "JumphostSubnet"

  address_prefixes = [
    var.snet_jumphost_addr_space,
  ]
}

resource "azurerm_subnet" "subnet_vpn" {
  virtual_network_name = azurerm_virtual_network.virtual_network_hub.name
  resource_group_name  = azurerm_resource_group.resource-group_hub.name
  name                 = "GatewaySubnet"

  address_prefixes = [
    var.snet_vpn_addr_space,
  ]
}

resource "azurerm_firewall" "firewall" {
  tags                = merge(var.tags, {})
  sku_tier            = "Premium"
  sku_name            = "AZFW_VNet"
  resource_group_name = azurerm_resource_group.resource-group_hub.name
  name                = "productionfirewall"
  location            = var.location
  firewall_policy_id  = azurerm_firewall_policy.firewall_policy.id

  ip_configuration {
    subnet_id            = azurerm_subnet.subnet_firewall.id
    public_ip_address_id = azurerm_public_ip.public_ip_app.id
    name                 = "configuration"
  }
}

resource "azurerm_public_ip" "public_ip_app" {
  tags                = merge(var.tags, {})
  sku                 = "Standard"
  resource_group_name = azurerm_resource_group.resource-group_hub.name
  name                = "pip_firewall"
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_firewall_policy" "firewall_policy" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group_hub.name
  name                = "firewallpolicy"
  location            = var.location
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_policy_rule_collection_group" {
  priority           = 100
  name               = "fwpolicy_rcg"
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id

  nat_rule_collection {
    priority = 100
    name     = "natrule_apgw"
    action   = "Dnat"
    rule {
      translated_port     = 80
      translated_address  = var.app_gateway_fe_ip
      name                = "rule_apgw"
      destination_address = var.demo_public_ip
      destination_ports = [
        "80",
      ]
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "*",
      ]
    }
  }

  network_rule_collection {
    priority = 200
    name     = "net_rule"
    action   = "Allow"
    rule {
      name = "network_rule_collection1_rule1"
      destination_addresses = [
        var.app_gateway_fe_ip,
      ]
      destination_ports = [
        "80",
        "443",
      ]
      protocols = [
        "TCP",
      ]
      source_addresses = [
        var.jumphost_ip,
      ]
    }
  }
}

resource "azurerm_public_ip" "public_ip_vpn" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group_hub.name
  name                = "pip_vpn"
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  type                = "Vpn"
  tags                = merge(var.tags, {})
  sku                 = "Standard"
  resource_group_name = azurerm_resource_group.resource-group_hub.name
  name                = "p2s-vpn"
  location            = var.location

  ip_configuration {
    subnet_id                     = azurerm_subnet.subnet_vpn.id
    public_ip_address_id          = azurerm_public_ip.public_ip_vpn.id
    private_ip_address_allocation = "Dynamic"
    name                          = "gatewayconfig"
  }

  vpn_client_configuration {
    address_space = [
      "10.242.0.0/24",
    ]
    root_certificate {
      public_cert_data = var.public_cert
      name             = "root-cert"
    }
    vpn_auth_types = [
      "Certificate",
    ]
  }
}

resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  tags                = merge(var.tags, {})
  size                = "Standard_DS2_v2"
  resource_group_name = azurerm_resource_group.resource-group_hub.name
  name                = "jumpostvm"
  location            = var.location
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.public_key
  }

  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  source_image_reference {
    version   = "latest"
    sku       = "20_04-lts-gen2"
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
  }
}

resource "azurerm_network_interface" "network_interface" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group_hub.name
  name                = "jumphostnic"
  location            = var.location

  ip_configuration {
    subnet_id                     = azurerm_subnet.subnet_jumphost.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.jumphost_ip
    name                          = "internal"
  }
}

