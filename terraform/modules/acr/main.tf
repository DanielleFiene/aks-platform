resource "azurerm_container_registry" "main" {
  name                = "acr${var.prefix}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false

  tags = {
    environment = "portfolio"
    managed_by  = "terraform"
  }
}
