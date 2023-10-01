provider "azurerm" {
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
}

resource "azurerm_kubernetes_cluster" "aks" {
  name = "my-aks-cluster"
  location = "eastus2"
  resource_group_name = var.resource_group_name
  node_resource_group = var.node_resource_group

  kubernetes_version = "1.23.9"
  default_node_pool {
    name = "apps"
    vm_size = "Standard_D2s_v3"
    node_count = 3
  }
}

resource "kubernetes_namespace" "apps" {
  metadata {
    name = "apps"
  }
}

resource "kubernetes_service_account" "apps" {
  metadata {
    name = "apps"
    namespace = kubernetes_namespace.apps.metadata[0].name
  }
}

