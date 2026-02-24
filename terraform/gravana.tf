########################
# Deploy Grafana via Helm
# - Uses official OCI chart
# - Deploys to 'monitoring' namespace
# - Exposes NodePort, sets default admin, disables persistence
########################
resource "helm_release" "grafana" {
  name      = "grafana"
  namespace = kubernetes_namespace.monitoring.metadata[0].name

  repository   = "oci://ghcr.io/grafana/helm-charts"
  chart        = "grafana"
  version      = "10.1.5"

  values = [
    yamlencode({
      service = {
        type = "NodePort"
      }
      grafana = {
        adminUser     = "admin"
        adminPassword = "admin"
        persistence   = { enabled = false }
      }
    })
  ]

  # Disable OCI chart signature verification
  verify = false
}

########################
# Fetch Grafana service info for NodePort access
########################
data "kubernetes_service" "grafana" {
  metadata {
    name      = "grafana"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }

  depends_on = [helm_release.grafana]
}