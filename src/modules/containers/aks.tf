resource "azurerm_kubernetes_cluster" "bank_aks" {
  name                = "bank-aks"
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_prefix = "bank-aks"
  sku_tier   = "Free"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.bank_aks.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.bank_aks.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.bank_aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.bank_aks.kube_config.0.cluster_ca_certificate)
}
