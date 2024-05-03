output "kube_config" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config_raw
}

