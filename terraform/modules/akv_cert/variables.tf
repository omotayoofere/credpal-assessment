variable "cert_validity" {
  type = number
}

variable "cert_dns_names" {
  type = list(string)
}

variable "azure_key_vault_id" {
  type = string
}

variable "akv_cert_name" {
  type = string
}

variable "cert_subject" {
  type = string
}

