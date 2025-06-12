provider "azurerm" {
  features {}

}
data "azurerm_client_config" "client_config" {}

resource "azurerm_resource_group" "resource_group" {
  name     = local.resource_group_name
  location = var.location

  tags = local.tags
}

module "key_vault" {
  source              = "./modules/keyvault"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  key_vault_name      = local.key_vault_name
  sku_name            = var.key_vault_sku_name
  tenant_id           = data.azurerm_client_config.client_config.tenant_id
  object_id           = data.azurerm_client_config.client_config.object_id
  tags                = local.tags
}

module "sql" {
  source                   = "./modules/sql"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = var.location
  sql_server_name          = local.sql_server_name
  sql_db_name              = local.sql_db_name
  key_vault_name           = local.key_vault_name
  sql_sku_name             = var.sql_sku_name
  sql_admin_secret_name    = local.sql_admin_secret_name
  sql_password_secret_name = local.sql_password_secret_name
  key_vault_id             = module.key_vault.key_vault_id

  depends_on = [module.key_vault]

  tags = local.tags
}

data "azurerm_key_vault_secret" "sql_username" {
  name         = local.sql_admin_secret_name
  key_vault_id = module.key_vault.key_vault_id
}

data "azurerm_key_vault_secret" "sql_password" {
  name         = local.sql_password_secret_name
  key_vault_id = module.key_vault.key_vault_id
}
data "azurerm_key_vault_secret" "sql_server_name" {
  name         = local.sql_server_name
  key_vault_id = module.key_vault.key_vault_id
}
data "azurerm_key_vault_secret" "sql_db_name" {
  name         = local.sql_db_name
  key_vault_id = module.key_vault.key_vault_id
}

module "web_app" {
  source                = "./modules/web_app"
  asp_name              = local.asp_name
  resource_group_name   = azurerm_resource_group.resource_group.name
  location              = var.location
  web_app_name          = local.web_app_name
  asp_sku               = var.asp_sku
  sql_connection_string = module.sql.sql_connection_string
  tags                  = local.tags
 
  envvars = {
    "SQL_USER" = data.azurerm_key_vault_secret.sql_username.value
    "SQL_PASSWORD" = data.azurerm_key_vault_secret.sql_password.value
    "SQL_SERVER"   = data.azurerm_key_vault_secret.sql_server_name.value
    "SQL_DATABASE"     = data.azurerm_key_vault_secret.sql_db_name.value
  }
  

  depends_on = [module.sql]
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  acr_sku             = var.acr_sku
  acr_name            = local.acr_name
  tags                = local.tags
}


module "aks" {
  source = "./modules/aks"

  aks_cluster_name    = local.aks_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  dns_prefix          = local.dns_prefix

  system_node_pool_name       = var.system_node_pool_name
  system_node_pool_node_count = var.system_node_pool_node_count
  system_node_pool_vm_size    = var.system_node_pool_vm_size

  acr_id       = module.acr.acr_id
  tenant_id    = data.azurerm_client_config.client_config.tenant_id
  key_vault_id = module.key_vault.key_vault_id

  tags       = local.tags
  depends_on = [module.acr, module.key_vault]
}

