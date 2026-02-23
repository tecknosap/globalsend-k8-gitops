# Create namespace for Argo CD
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }

  depends_on = [
    kind_cluster.globalsend
  ]
}

# Install Argo CD with Helm
resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.51.6"

  values = [
    yamlencode({
      server = {
        service = {
          type = "ClusterIP"
        }
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.argocd
  ]
}

# Get the Argo CD initial admin password
data "kubernetes_secret" "argocd_initial_password" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }

  depends_on = [
    helm_release.argocd
  ]
}

# Output the Argo CD admin password
output "argocd_admin_password" {
  value     = nonsensitive(data.kubernetes_secret.argocd_initial_password.data["password"])
  description = "Argo CD initial admin password"
}

# Output command to port-forward Argo CD UI
output "argocd_port_forward" {
  value = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
}