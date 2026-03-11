output "blob_storage_id" {
    value = azurerm_storage_blob.storage_blob.id
}

output "blob_storage_name" {
    value = azurerm_storage_blob.storage_blob.name
}

output "blob_storage_access_tier" {
    value = azurerm_storage_blob.storage_blob.access_tier
}