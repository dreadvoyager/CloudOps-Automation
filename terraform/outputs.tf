# output "acr_login_url" {
#   description = "The login URL of the Azure Container Registry."
#   value       = module.acr.login_url

# }
output "sql_server_fqdn" {
  description = "The fully qualified domain name of the SQL server."
  value       = module.sql.sql_server_fqdn

}
output "web_app_default_hostname" {
  description = "The default hostname of the web app."
  value       = module.web_app.web_app_default_hostname

}
# output "aks_lb_ip" {
#   description = "The IP address of the AKS load balancer."
#   value       = module.aks_lb.ip_address

# }

