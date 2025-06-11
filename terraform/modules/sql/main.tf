resource "random_password" "sql_password" {
  length  = 16
  special = true
}

resource "azurerm_mssql_server" "server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_password.result
  tags                         = var.tags
}

resource "azurerm_mssql_firewall_rule" "azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"

}

resource "azurerm_mssql_database" "db" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.server.id
  sku_name  = var.sql_sku_name
  tags      = var.tags

}


resource "azurerm_key_vault_secret" "sql_username" {
  name         = var.sql_admin_secret_name
  value        = var.sql_admin_username
  key_vault_id = var.key_vault_id
}
resource "azurerm_key_vault_secret" "sql_password" {
  name         = var.sql_password_secret_name
  value        = random_password.sql_password.result
  key_vault_id = var.key_vault_id
  depends_on   = [random_password.sql_password]
}

