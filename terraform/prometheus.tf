
# Deploy Prometheus stack, auto-scraping cluster metrics
resource "helm_release" "prometheus" {
  name      = "prometheus"
  namespace = kubernetes_namespace.monitoring.metadata[0].name

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "80.13.3"

  values = [
    yamlencode({
      prometheus = {
        prometheusSpec = {
          serviceMonitorSelectorNilUsesHelmValues = false
          serviceMonitorSelector = {}  # select all ServiceMonitors
          podMonitorSelector     = {}  # select all PodMonitors
          service = { type = "NodePort" } # optional NodePort
        }
      }
      grafana = { enabled = true }  # skip Grafana
      alertmanager = { enabled = true }
    })
  ]
}

# Get Prometheus service info
data "kubernetes_service" "prometheus" {
  metadata {
    name      = "prometheus-kube-prometheus-prometheus"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }

  depends_on = [helm_release.prometheus]
}

# Outputs
output "prometheus_nodeport" {
  value       = data.kubernetes_service.prometheus.spec[0].port[0].node_port
  description = "NodePort for accessing Prometheus"
}

output "prometheus_url" {
  value       = "http://localhost:${data.kubernetes_service.prometheus.spec[0].port[0].node_port}"
  description = "URL to access Prometheus"
}