variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}
variable "location" {
  description = "The Azure region where the SQL server and database will be created."
  type        = string
}
variable "sql_server_name" {
  description = "The name of the SQL server."
  type        = string
}
variable "sql_db_name" {
  description = "The name of the SQL database."
  type        = string
}
variable "key_vault_name" {
  description = "The name of the Key Vault where secrets will be stored."
  type        = string
}

variable "sql_sku_name" {
  description = "The SKU name for the SQL database."
  type        = string
}
variable "sql_admin_secret_name" {
  description = "The name of the secret in Key Vault for the SQL administrator username."
  type        = string
}
variable "sql_password_secret_name" {
  description = "The name of the secret in Key Vault for the SQL administrator password."
  type        = string
}
variable "key_vault_id" {
  description = "The ID of the Key Vault where secrets will be stored."
  type        = string
}
variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}