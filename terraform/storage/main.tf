provider "azurerm" {
  features {}
  subscription_id = var.azure_sub_id
}

module "storage_account" {
  source = "../modules/storage_account"
  storage_account_name = var.storage_account_name
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  tags = local.common_tags
}

module "storage_container" {
  depends_on = [ module.storage_account ]
  source = "../modules/storage_container"
  storage_container_name = var.storage_container_name
  storage_account_id = module.storage_account.storage_acct_id
}

module "storage_blob" {
  depends_on = [ module.storage_container ]
  source = "../modules/storage_blob"
  storage_blob_name = var.storage_blob_name
  storage_container_name = var.storage_container_name
  # absolute_storage_path = var.absolute_storage_path
  storage_account_name = var.storage_account_name
}

