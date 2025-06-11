variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string

}
variable "location" {
  description = "The Azure region where the container registry will be created."
  type        = string

}
variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}
variable "acr_sku" {
  description = "The SKU for the Azure Container Registry."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)

}
