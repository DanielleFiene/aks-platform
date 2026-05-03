output "acr_login_server" {
  value = module.acr.login_server
}

output "cluster_name" {
  value = module.aks.cluster_name
}

output "resource_group" {
  value = azurerm_resource_group.main.name
}

output "db_fqdn" {
  value = module.database.fqdn
}
