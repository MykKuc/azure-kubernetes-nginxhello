terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.37.0"
    }
  }
}

provider "aws" {
    features {}
}

resource "azurerm_resource_group" "nginx_resource_group" {
    name = "kubernetes-nginx-resource-group"
    location = "Sweden Central"
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster_nginxhello" {
    name = "nginxhellocluster"
    resource_group_name = azurerm_resource_group.nginx_resource_group.name
    location = azurerm_resource_group.nginx_resource_group.location
    dns_prefix = "nginxhello1"

    default_node_pool {
      name = "default"
      node_count = 2
      vm_size = "Standard_B2s"
    }


    identity {
    type = "SystemAssigned"
    }
}