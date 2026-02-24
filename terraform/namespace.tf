########################
# Namespace for all monitoring components
# (Prometheus, Grafana, etc.)
########################
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}