# Terraform version and required providers
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.0.17"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

# Provider for managing local KIND clusters
provider "kind" {}

# Kubernetes provider using local kubeconfig
provider "kubernetes" {
  config_path = var.kubeconfig_path
}

# Default Helm provider using local kubeconfig
provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

# Helm provider with alias for KIND-specific usage
provider "helm" {
  alias = "kind"

  kubernetes {
    config_path = var.kubeconfig_path
  }
}