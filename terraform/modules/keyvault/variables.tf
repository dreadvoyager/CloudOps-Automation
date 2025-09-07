variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string

}
variable "location" {
  description = "The Azure region where the key vault will be created."
  type        = string

}
variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the Key Vault."
  type        = string
}
variable "tenant_id" {
  description = "The tenant ID for the Key Vault access policy."
  type        = string
}
variable "object_id" {
  description = "The object ID for the Key Vault access policy."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Key Vault."
  type        = map(string)
}