output "sql_server_fqdn" {
  description = "The fully qualified domain name of the SQL server."
  value       = module.sql.sql_server_fqdn

}
output "web_app_default_hostname" {
  description = "The default hostname of the web app."
  value       = module.web_app.web_app_default_hostname

}


