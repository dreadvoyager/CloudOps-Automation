resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = var.sku_name
  tags                = var.tags

}
resource "azurerm_key_vault_access_policy" "access_policy" {
  key_vault_id       = azurerm_key_vault.kv.id
  tenant_id          = var.tenant_id
  object_id          = var.object_id
  secret_permissions = ["Get", "Set", "Delete", "List", "Purge", "Recover"]

}