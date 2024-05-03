# Azure landing zone baseline


## Description

This reference architecture provides a recommended infrastructure architecture to deploy a Landing Zone in one Subscription in Azure. It is based on architectural and terraform best practices in terms of networking, security, and application.

This architecture is focused on the Landing Zone concepts where we have two separate entities, hub and spoke and the workflow consists of connections coming from hub-to-spoke. The architecture can serve as a baseline and can be scaled according to the business needs. It ensures a network topology that supports multi-regional growth, and secures the in-cluster traffic.

You can consider this infrastructure as your starting point for pre-production and production stages.

## Network Topology

The topology of the network that this architecture uses is hub and spoke. Both these entities are deployed in two separate virtual networks that are connected through peering. One of the advantages of this architecture is that is minimizes direct exposure of Azure resources to the public internet.

The central point of the architecture will be the Hub Network. All the connections will first come in the Hub layer and then pass to the Spoke layer. The hub will contain an Azure Firewall connected to firewall policies that will be configured based on the need of the organization, a gateway for VPN connectivity, and a Jump host where connections will pass through to Spoke.

The spoke Vnet consists of an AKS Cluster, a Mysql Flexible server and a KeyVault.

## How to use the architecture

Go to the templates and clone the architecture. Modify the fowllowing variables according to your needs:

| Variable | Description |
| --- | --- |
| admin_pass | Password for the Database admin |
| app_gateway_fe_ip | Application gateway Frontend IP |
| client_ip_pool | Client IP pool |
| demo_public_ip | The public IP for the Firewall connections |
| jumphost_ip | The public IP for the Jumphost |
| location | Location |
| public_cert | Public certification |
| public_key | Public key |
| snet_ag_addr_space | The address space for the Application Gateway Subnet |
| snet_cluster_addr_space | The address space for the Kubernetes Subnet |
| snet_database_addr_space | The address space for the Database Subnet |
| snet_firewall_addr_space | The address space for the Firewall Subnet |
| snet_jumphost_addr_space | The address space for the Jumphost Subnet |
| snet_pe_addr_space | The address space for the Private Endpoint Subnet |
| snet_vpn_addr_space | The address space for the VPN Subnet |
| tags | Default tags to apply to all resources. |
| vnet_hub_addr_space | The address space for the Hub Virtual Network |
| vnet_spoke_addr_space | The address space for the Spoke Virtual Network |

# Maintainer(s)

- [Brainboard team](mailto:support@brainboard.co)
