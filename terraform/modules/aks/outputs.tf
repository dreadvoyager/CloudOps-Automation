output "aks_kube_config" {
  description = "Kubernetes configuration for the AKS cluster."
  value       = azurerm_kubernetes_cluster.k8_cluster.kube_config_raw
}
output "aks_kv_access_identity_id" {
  description = "The ID of the Key Vault access identity for the AKS cluster."
  value       = azurerm_kubernetes_cluster.k8_cluster.key_vault_secrets_provider[0].secret_identity[0].object_id


}