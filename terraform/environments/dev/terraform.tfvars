environment              = "dev"
location                 = "West US"
sql_admin_username       = "devsqladmin"
sql_admin_secret_name    = "dev-sql-admin"
sql_password_secret_name = "dev-sql-password"
sql_sku_name             = "Basic"
key_vault_sku_name       = "standard"

acr_sku = "Standard"

system_node_pool_name       = "system"
system_node_pool_node_count = 1
system_node_pool_vm_size    = "Standard_D2ads_v5"