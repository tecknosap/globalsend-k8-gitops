
resource "helm_release" "grafana" {
  name      = "grafana"
  namespace = kubernetes_namespace.monitoring.metadata[0].name

  repository   = "oci://ghcr.io/grafana/helm-charts"
  chart        = "grafana"
  version      = "10.1.5"

  # Grafana chart values
  values = [
    yamlencode({
      service = {
        type = "NodePort"
      }
      adminUser     = "admin"
      adminPassword = "admin"
      persistence = {
        enabled = false
      }
    })
  ]

  # Needed so OCI charts do not try to verify signatures
  verify = false
}

data "kubernetes_service" "grafana" {
  metadata {
    name      = "grafana"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }

  depends_on = [helm_release.grafana]
}

output "grafana_nodeport" {
  value       = data.kubernetes_service.grafana.spec[0].port[0].node_port
  description = "NodePort for accessing Grafana"
}

output "grafana_url" {
  value       = "http://localhost:${data.kubernetes_service.grafana.spec[0].port[0].node_port}"
  description = "URL to access Grafana"
}