########################
# Argo CD namespace
# - Isolates Argo CD resources
# - Depends on local Globalsend KIND cluster
########################
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }

  depends_on = [
    kind_cluster.globalsend
  ]
}

########################
# Deploy Argo CD via Helm
# - ClusterIP service for the server
# - Deploys to 'argocd' namespace
# - Version 5.51.6
########################
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

########################
# Fetch Argo CD initial admin password
# - Stored as Kubernetes secret by Helm chart
# - Required for first login
########################
data "kubernetes_secret" "argocd_initial_password" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }

  depends_on = [
    helm_release.argocd
  ]
}