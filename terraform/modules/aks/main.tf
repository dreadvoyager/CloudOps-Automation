resource "azurerm_kubernetes_cluster" "k8_cluster" {
  name                   = var.aks_cluster_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  dns_prefix             = "${var.dns_prefix}-dns"
  local_account_disabled = false

  default_node_pool {
    name            = var.system_node_pool_name
    node_count      = var.system_node_pool_node_count
    vm_size         = var.system_node_pool_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  oidc_issuer_enabled = true

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "role_assignment" {
  role_definition_name = "AcrPull"
  scope                = var.acr_id
  principal_id         = azurerm_kubernetes_cluster.k8_cluster.kubelet_identity[0].object_id

  depends_on = [azurerm_kubernetes_cluster.k8_cluster]
}

resource "azurerm_key_vault_access_policy" "access_policy1" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_kubernetes_cluster.k8_cluster.key_vault_secrets_provider[0].secret_identity[0].object_id

  secret_permissions = ["Get", "List"]

  depends_on = [azurerm_role_assignment.role_assignment]
}

resource "azurerm_key_vault_access_policy" "access_policy2" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_kubernetes_cluster.k8_cluster.kubelet_identity[0].object_id

  secret_permissions = ["Get", "List"]

  depends_on = [azurerm_key_vault_access_policy.access_policy1]
}