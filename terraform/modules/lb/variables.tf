variable "lb_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "public_ip_id" {
  type = string
}

variable "address_pool_name" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "backends" {
  type = map(string)
}

variable "lb_frontend_port" {
  type = string
}

variable "lb_backend_port" {
  type = string
}
