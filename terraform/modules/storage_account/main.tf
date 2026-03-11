# Creates a network interface for a VM, with optional public IP

resource "azurerm_storage_account" "storage_account" {
  name = var.storage_account_name
  resource_group_name = var.rg_name
  location = var.rg_region
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}
