variable "environment" {
  description = "The environment for the resources (e.g., dev, qa, staging, prod)."
  type        = string
}
variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string

}
variable "system_node_pool_name" {
  description = "The name of the system node pool."
  type        = string

}
variable "system_node_pool_node_count" {
  description = "The number of nodes in the system node pool."
  type        = number

}
variable "system_node_pool_vm_size" {
  description = "The VM size for the system node pool."
  type        = string

}
variable "sql_admin_username" {
  description = "The username for the SQL admin."
  type        = string

}
variable "sql_admin_secret_name" {
  description = "The name of the secret in Key Vault for the SQL admin username."
  type        = string

}
variable "sql_password_secret_name" {
  description = "The name of the secret in Key Vault for the SQL admin password."
  type        = string

}
variable "sql_sku_name" {
  description = "The SKU name for the SQL database."
  type        = string

}

variable "key_vault_sku_name" {
  description = "The SKU name for the Key Vault."
  type        = string
  default     = "Standard"
}

variable "asp_sku" {
  description = "The SKU for the App Service Plan."
  type        = string
  default     = "S1"
}
variable "acr_sku" {
  description = "The SKU for the Azure Container Registry."
  type        = string
  default     = "Standard"
}

