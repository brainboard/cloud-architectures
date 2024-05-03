variable "Azure_SP_object_id" {
  description = "Object id of the user Chafik."
  type        = string
}

variable "Brainboard_IP_range_list" {
  description = "Brainboard fixed IPs to allow-list."
  type        = list(string)
  default = [
    "3.18.12.57",
    "3.19.117.9",
    "3.12.21.31",
    "3.140.65.244",
    "18.223.219.168",
    "3.139.254.14"
  ]
}

variable "admin_pass" {
  description = "Password for the Database admin"
  type        = string
  default     = "bR@INB0ARD"
  sensitive   = true
}

variable "app_gateway_fe_ip" {
  description = "Application gateway Frontend IP"
  type        = string
  default     = "10.241.5.10"
}

variable "brainboard_object_id" {
  description = "This is the object ID of the terraform manager"
  type        = string
  default     = "0fa5cdbb-8a17-44ec-b6c1-157eaf299516"
}

variable "client_ip_pool" {
  description = "Client IP pool"
  type        = string
  default     = "10.242.0.0/24"
}

variable "demo_public_ip" {
  description = "The public IP for the Firewall connections"
  type        = string
  default     = "23.34.55.68"
}

variable "jumphost_ip" {
  description = "The public IP for the Jumphost"
  type        = string
  default     = "10.240.2.10"
}

variable "location" {
  description = "Location"
  type        = string
  default     = "East US"
}

variable "public_cert" {
  description = "Public certification"
  type        = string
  default     = "MIIC5jCCAc6gAwIBAgIISHlcsJpjnuswDQYJKoZIhvcNAQELBQAwETEPMA0GA1UEAxMGVlBOIENBMB4XDTIyMTExNjIwMDkyOVoXDTI1MTExNTIwMDkyOVowETEPMA0GA1UEAxMGVlBOIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhL9kLYbV+NNM2OtJAT7C8Af+tB+8+bQXHQy0wnPKTLMfGtUA18VRDmO4/IUHDkusoe4TDTpeJoKZGfBJnbS+JUy3oV05eEUi1PoTcGYCveAEBUbbFxo5eg08TIK/A2f4T6bbxfeMm0lPEFkYFJI0norrP4YGiKuW5HQXvrtj7XrHp2Nxdx7prGghW4L9nwEqGTiJO8WuVCVu4tutIghu2cLt/4UudY9CcmwwsjuS6BJ2dE8cVeLJzMwBLwWOE1VaP/5lioLW0uCNx0h2CuhwD9Qxy00xoxCZsIblQB6pmAP1uNCFdV0WljBPjgJBPLTox9RFxpcgk/z2CqpASOGkgQIDAQABo0IwQDAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQU4ABUigtYXHrJJkQtaYDE0hmTw94wDQYJKoZIhvcNAQELBQADggEBAE+HarlC6WtDOZIP9pGvVHc59RvJXFMrSvRqqs1H3pWzJrjCdPTqWxE2uFeTsWuv8AhKADIjSWSMsEBqfc/2GRzoGSeYL3d9tF+9mG1XZ6vcQlfxDcZi945l0cDA2Q1DQOqfbO9YYQvOeE0b6UPsG9Lu16FklHvuTa1qh5RaCIYiqqKcUwv0dOSnoj7E3oWKcsuc/jpnU6ZUrydJrQCxnI5vlMHzQWhghrXNVf1a+fNkfnGynGNR44LOBT/8kpveoVg3jvPzENfjE60mzJNfcEznkDF+PG2G56xw1VyhE8Ulx5sZFj9oJxzFCz1OOEPdXl8/gcPEmac8EifAMi9wZKY="
}

variable "public_key" {
  description = "Public Key"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDMBQOzfmS70QaparH21jWVlkiPzczur9/FFmsTyoNsLElfXnZOW4gV2VNPrE1+qLANnudFxXKtgm/EK61+waJyK+tXr32VHM2noKc2FnDqAxk29HmrPa2vPJvufTTiNmMrMk4GLxY8kWxh66iTkdGsjAzDV5WY2zmIAlYpSajQbfYA1YaHIi2OmicfpaNLEmogbuy/47+QfIGRiACNnNUOccCuDcXxq6gN3ZJUZAHCQC92O4AlTBXHnfoX0Q1X80RGuo7dGoYc+TyjBSiedNJq32sV25/g7J3GB5ZVX61aIJfZjceZLlkkCWNW9IjO3sgA1DUpc31pqsOhkjk5OKgHf4qBzIG/jUKuGL7CT/JcxxSNGtUvJuUVKcYgDXo+I6mFBA2caM9okGlqGaOqJvW7BkKFZXfoJcJyiLs4mrngIHK6oFo2ziZWWRwk0blbPO0wS+p305e9ziZRmUpf46XIslo7S/WWn0ucY8wAoSPPDpsrg7+Xyg1jJ0s5zuiJgE= marsela@Marselas-MacBook-Pro.local"
}

variable "rg_hub_name" {
  type    = string
  default = "rg_hub"
}

variable "rg_spoke_name" {
  type    = string
  default = "rg-spoke"
}

variable "snet_ag_addr_space" {
  description = "The address space for the Application Gateway Subnet"
  type        = string
  default     = "10.241.5.0/24"
}

variable "snet_cluster_addr_space" {
  description = "The address space for the Kubernetes Subnet"
  type        = string
  default     = "10.241.0.0/22"
}

variable "snet_database_addr_space" {
  description = "The address space for the Database Subnet"
  type        = string
  default     = "10.241.6.0/24"
}

variable "snet_firewall_addr_space" {
  description = "The address space for the Firewall Subnet"
  type        = string
  default     = "10.240.1.0/24"
}

variable "snet_jumphost_addr_space" {
  description = "The address space for the Jumphost Subnet"
  type        = string
  default     = "10.240.2.0/24"
}

variable "snet_pe_addr_space" {
  description = "The address space for the Private Endpoint  Subnet"
  type        = string
  default     = "10.241.4.0/24"
}

variable "snet_vpn_addr_space" {
  description = "The address space for the VPN Subnet"
  type        = string
  default     = "10.240.240.0/24"
}

variable "tags" {
  description = "Default tags to apply to all resources."
  type        = map(any)
  default     = {}
}

variable "vnet_hub_addr_space" {
  description = "The address space for the Hub Virtual Network"
  type        = string
  default     = "10.240.0.0/16"
}

variable "vnet_spoke_addr_space" {
  description = "The address space for the Spoke Virtual Network"
  type        = string
  default     = "10.241.0.0/16"
}

