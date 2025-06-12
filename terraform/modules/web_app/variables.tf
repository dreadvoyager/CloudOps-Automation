variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string

}
variable "location" {
  description = "The Azure region where the web app will be created."
  type        = string

}
variable "asp_name" {
  description = "The name of the App Service Plan."
  type        = string

}
variable "web_app_name" {
  description = "The name of the web app."
  type        = string

}
variable "sql_connection_string" {
  description = "The SQL connection string for the web app."
  type        = string

}
variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}

}
variable "asp_sku" {
  description = "The SKU tier for the App Service Plan."
  type        = string

}
variable "envvars" {
  description = "A map of environment variables to set for the web app."
  type        = map(string)
  sensitive = true
}