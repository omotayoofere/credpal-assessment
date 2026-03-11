provider "azurerm" {
  features {}
  subscription_id = var.azure_sub_id
}

module "vnet" {
  source = "../modules/vnet"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  vnet_addr_space = var.vnet_addr_space
  vnet_name = var.vnet_name
}

module "private_subnet" {
  source = "../modules/subnet"
  subnet_addr_space = var.private_subnet_addr_space
  subnet_name = var.private_subnet_name
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  vnet_name = module.vnet.vnet_name
}

module "appgateway_subnet" {
  source = "../modules/subnet"
  subnet_addr_space = var.appgateway_subnet_addr_space
  subnet_name = var.appgateway_subnet_name
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  vnet_name = module.vnet.vnet_name
}

module "vm1" {
  source = "../modules/vm"
  subnet_id = module.private_subnet.subnet_id
  vm_name = var.vm1_name
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  vm_nic = var.vm1_nic_name
  tags = merge(
    local.common_tags
  )
}

module "vm2" {
  source = "../modules/vm"
  subnet_id = module.private_subnet.subnet_id
  vm_name = var.vm2_name
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  vm_nic = var.vm2_nic_name
  tags = merge(
    local.common_tags
  )
}

module "lb_public_ip" {
  source = "../modules/publicIp"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  ip_name = var.lb_ip_name
  tags = merge(
    local.common_tags
  )
}

module "app_gateway_user_assigned_id" {
  source = "../modules/user_assigned_identities"
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  user_assigned_identity_name = var.app_gateway_user_assigned_id_name
  common_tags = merge(
    local.common_tags
  )
}

module "azure_key_vault" {
  source = "../modules/akv"
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  akv_name = var.akv_name
}

module "azure_key_vault_access_policy" {
  source = "../modules/akv_access_policy"
  azure_key_vault_id = module.azure_key_vault.akv_id
  azure_tenant_id = var.tenant_id
  # certificate_permissions = var.certificate_permissions
  # key_permissions = var.key_permissions
  secret_permissions = var.secret_permissions
  azure_user_object_id = module.app_gateway_user_assigned_id.user_assigned_principal_id
}

module "current_user_policy" {
  source = "../modules/akv_access_policy"
  azure_key_vault_id = module.azure_key_vault.akv_id
  azure_tenant_id = var.tenant_id
  key_permissions = ["Get", "List", "Backup", "Delete", "Purge", "Recover", "Restore", "Create"]
  azure_user_object_id = "b636ab7a-6a60-40d0-8d01-c90708c4bd1f"
  secret_permissions = ["Get", "List", "Backup", "Delete", "Purge", "Recover", "Restore", "Set"]
}

module "azure_keyvault_cert" {
  depends_on = [ module.current_user_policy, module.azure_key_vault_access_policy ]
  source = "../modules/akv_cert"
  cert_validity = var.cert_validity
  cert_dns_names = var.cert_dns_names
  akv_cert_name = var.akv_cert_name
  azure_key_vault_id = module.azure_key_vault.akv_id
  cert_subject = var.cert_subject
}

module "appgateway" {
  depends_on = [ module.azure_keyvault_cert ]
  source = "../modules/appGateway"
  instance_count = var.instance_count
  frontend_port = var.frontend_port
  sku_name = var.sku_name
  sku_tier = var.sku_tier
  gateway_subnet_id = module.appgateway_subnet.subnet_id
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  app_gateway_name = var.app_gateway_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  frontend_ip_addr = module.lb_public_ip.ip_address_id
  backends = {
    vm1 = module.vm1.vm_nic_id
    vm2 = module.vm2.vm_nic_id
  }
  appgw_cert_secret_id = module.azure_keyvault_cert.appgw_cert_secret_id
  ssl_certificate_name = var.ssl_certificate_name
  app_gateway_user_assigned_id = [module.app_gateway_user_assigned_id.user_assigned_id]
}

