output "web_app_default_hostname" {
  description = "The hostname of the web app."
  value       = azurerm_linux_web_app.webapp.default_hostname

}