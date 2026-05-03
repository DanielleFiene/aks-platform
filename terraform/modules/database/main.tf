resource "azurerm_postgresql_flexible_server" "main" {
  name                   = "psql-${var.prefix}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = "15"
  administrator_login    = "pgadmin"
  administrator_password = var.db_password
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
  backup_retention_days  = 7

  tags = {
    environment = "portfolio"
    managed_by  = "terraform"
  }
}

resource "azurerm_postgresql_flexible_server_database" "uptime" {
  name      = "uptime"
  server_id = azurerm_postgresql_flexible_server.main.id
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure" {
  name             = "allow-azure-services"
  server_id        = azurerm_postgresql_flexible_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
