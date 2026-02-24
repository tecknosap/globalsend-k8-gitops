########################
# Deploy Prometheus stack with Grafana and Alertmanager
# - Installs kube-prometheus-stack via Helm
# - Exposes Prometheus service as NodePort
# - Deploys to 'monitoring' namespace
########################
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
          service = { type = "NodePort" }
        }
      }
      grafana = { enabled = true }
      alertmanager = { enabled = true }
    })
  ]
}

########################
# Get Prometheus service details for NodePort access
########################
data "kubernetes_service" "prometheus" {
  metadata {
    name      = "prometheus-kube-prometheus-prometheus"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }

  depends_on = [helm_release.prometheus]
}