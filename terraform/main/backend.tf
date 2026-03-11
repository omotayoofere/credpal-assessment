terraform {
  backend "azurerm" {
    resource_group_name = "Tayo_Amos_RG"
    storage_account_name = "10credpalassessment2026"
    container_name = "assessment-resources"
    key = "terraform.tfstate"
    use_azuread_auth = true
  }
}