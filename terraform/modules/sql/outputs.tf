output "sql_connection_string" {
  description = "Connection string for connecting to the SQL database."
  value = format(
    "Server=tcp:%s,1433;Initial Catalog=%s;Persist Security Info=False;User ID=%s;Password=%s;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
    azurerm_mssql_server.server.fully_qualified_domain_name,
    azurerm_mssql_database.db.name,
    var.sql_admin_username,
    random_password.sql_password.result
  )
  sensitive = true
}
output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL server."
  value       = azurerm_mssql_server.server.fully_qualified_domain_name
}
