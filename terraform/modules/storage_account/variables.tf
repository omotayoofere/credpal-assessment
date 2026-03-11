variable "rg_name" {
  description = "Name of resource group"
  type = string
}

variable "rg_region" {
  description = "Location of resource group"
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "tags" {
  description = "Common tags for all module resources"
  type        = map(string)
}