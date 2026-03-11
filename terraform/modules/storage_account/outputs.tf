output "storage_acct_id" {
    value = azurerm_storage_account.storage_account.id
}

output "storage_acct_name" {
    value = azurerm_storage_account.storage_account.name
}

output "storage_acct_blob_endpoint" {
    value = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "storage_acct_blob_host" {
    value = azurerm_storage_account.storage_account.primary_blob_internet_host
}

