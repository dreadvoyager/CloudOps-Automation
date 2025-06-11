variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string

}
variable "location" {
  description = "The Azure region where the AKS cluster will be created."
  type        = string

}
variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string

}
variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
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
variable "acr_id" {
  description = "The ID of the Azure Container Registry (ACR) to which the AKS cluster will be granted access."
  type        = string
}
variable "key_vault_id" {
  description = "The ID of the Key Vault where secrets will be stored."
  type        = string

}
variable "tenant_id" {
  description = "The Azure tenant ID."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}