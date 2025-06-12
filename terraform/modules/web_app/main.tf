resource "azurerm_service_plan" "asp" {
  name                = var.asp_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.asp_sku
  tags                = var.tags

}
resource "azurerm_linux_web_app" "webapp" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = true
    application_stack {
      node_version = "16-lts"
    }
  }
  app_settings = var.envvars
  connection_string {
    name  = "SQLConnectionString"
    type  = "SQLAzure"
    value = var.sql_connection_string
  }
  tags = var.tags

}