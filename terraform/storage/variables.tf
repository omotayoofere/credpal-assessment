variable "azure_sub_id" {
  description = "ID of azure subscription"
  type        = string
}

variable "common_tags" {
  description = "Common tag for all resources"
  type        = map(string)
  default = {
    Owner   = "Emart-group"
    Project = "Emart"
    CSP     = "Azure"
  }
}

variable "storage_account_name" {
  type        = string
}

variable "storage_container_name" {
  type = string
}

variable "storage_blob_name" {
  type = string
}

# variable "absolute_storage_path" {
#   type = string
# }