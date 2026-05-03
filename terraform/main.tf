terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.prefix}"
  location = var.location

  tags = {
    environment = "portfolio"
    managed_by  = "terraform"
  }
}

module "acr" {
  source              = "./modules/acr"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

module "aks" {
  source              = "./modules/aks"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  acr_id              = module.acr.id
}

module "database" {
  source              = "./modules/database"
  prefix              = var.prefix
  location            = var.db_location
  resource_group_name = azurerm_resource_group.main.name
  db_password         = var.db_password
  db_prefix           = var.db_prefix
}
