output "appgw_cert_secret_id" {
  value = azurerm_key_vault_certificate.akv_cert.secret_id
  sensitive = true
}