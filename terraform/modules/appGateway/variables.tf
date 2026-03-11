variable "rg_name" {
  description = "Name of resource group"
  type = string
}

variable "app_gateway_name" {
  description = "Name of app gateway"
  type = string
}

variable "rg_region" {
  description = "Location of resource group"
  type = string
}

variable "gateway_subnet_id" {
  description = "ID of gateway subnet"
  type = string
}

variable "frontend_port" {
  description = "Port number of frontend"
  type = number
}

variable "frontend_ip_addr" {
  description = "ID of frontend IP"
  type = string
}

variable "sku_name" {
  description = "SKU of app gateway"
  type = string
}

variable "sku_tier" {
  description = "Tier of app gateway"
  type = string
}

variable "instance_count" {
  description = "Count of instance"
  type = number
}

variable "backends" {
  type = map(string)
}

variable "app_gateway_user_assigned_id" {
  type = list(string)
}

variable "ssl_certificate_name" {
  type = string
}

variable "appgw_cert_secret_id" {
  type = string
}