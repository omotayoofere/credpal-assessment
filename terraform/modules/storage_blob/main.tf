resource "azurerm_storage_blob" "storage_blob" {
  name = var.storage_blob_name
  storage_account_name = var.storage_account_name
  storage_container_name = var.storage_container_name
  type = "Block"
  # source = var.absolute_storage_path
}