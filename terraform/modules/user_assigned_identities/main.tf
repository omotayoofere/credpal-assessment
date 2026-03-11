# Creates a user-assigned managed identity to be used by AKS workloads via Workload Identity

resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  location = var.rg_region
  name = var.user_assigned_identity_name #Name of the managed identity
  resource_group_name = var.rg_name #Resource group containing the identity

  tags = var.common_tags
}