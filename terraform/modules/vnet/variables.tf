variable "rg_region" {
  description = "Location of resource group"
  type = string
}

variable "vnet_addr_space" {
  description = "Address space of VNET"
  type = list(string)
}

variable "rg_name" {
  description = "Name of resource group"
  type = string
}

variable "vnet_name" {
  description = "Name of vnet"
  type = string
}