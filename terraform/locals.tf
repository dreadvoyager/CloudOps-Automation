locals {
  tags = {
    environment = var.environment
    owner       = "adeebahmed_khan@epam.com"
    project     = "Azure Intern Project"
  }
  resource_group_name      = "proj-${var.environment}-rg"
  sql_server_name          = "proj-${var.environment}-sqlserver"
  sql_db_name              = "proj-${var.environment}-sqldb"
  key_vault_name           = "${var.environment}-ak-kv"
  acr_name                 = "proj${var.environment}acr"
  asp_name                 = "${var.environment}-asp"
  web_app_name             = "proj-${var.environment}-webapp"
  aks_name                 = "proj-${var.environment}-aks"
  dns_name_label           = "${var.environment}dnslabel"
  dns_prefix               = "${var.environment}-k8s"
  sql_admin_secret_name    = "${var.environment}-sql-admin"
  sql_password_secret_name = "${var.environment}-sql-password"
}