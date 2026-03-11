variable "rg_name" {
  description = "Name of resource group"
  type = string
}

variable "user_assigned_identity_name" {
  type = string
}

variable "rg_region" {
  description = "Location of resource group"
  type = string
}

variable "common_tags" {
  description = "Common tags for all module resources"
  type = map(string)
}