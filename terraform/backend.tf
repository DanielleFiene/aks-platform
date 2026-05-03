terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "staksplatformstate"
    container_name       = "tfstate"
    key                  = "aks-platform.tfstate"
  }
}
