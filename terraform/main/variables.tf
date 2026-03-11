variable "azure_sub_id" {
  description = "ID of azure subscription"
  type = string
}

variable "private_subnet_name" {
  type = string
}

variable "private_subnet_addr_space" {
  type = list(string)
}

variable "appgateway_subnet_name" {
  type = string
}

variable "appgateway_subnet_addr_space" {
  type = list(string)
}

variable "vnet_addr_space" {
  type = list(string)
}

variable "vnet_name" {
  type = string
}

variable "vm1_name" {
  type = string
}

variable "vm1_nic_name" {
  type = string
}

variable "vm2_name" {
  type = string
}

variable "vm2_nic_name" {
  type = string
}

variable "lb_ip_name" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "address_pool_name" {
  type = string
}

variable "lb_backend_port" {
  type = string
}

variable "lb_frontend_port" {
  type = string
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

variable "app_gateway_user_assigned_id_name" {
  type = string
}

variable "akv_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

# variable "certificate_permissions" {
#   type = list(string)
# }

# variable "key_permissions" {
#   type = list(string)
# }

variable "secret_permissions" {
  type = list(string)
}

variable "akv_cert_name" {
  type = string
}

variable "cert_subject" {
  type = string
}

variable "cert_validity" {
  type = number
}

variable "cert_dns_names" {
  type = list(string)
}

variable "frontend_port" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "sku_name" {
  type = string
}

variable "sku_tier" {
  type = string
}

variable "app_gateway_name" {
  type = string
}

variable "ssl_certificate_name" {
  type = string
}
