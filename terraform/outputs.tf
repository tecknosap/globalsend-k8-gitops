# Prometheus outputs: NodePort and localhost URL
output "prometheus_nodeport" {
  value       = data.kubernetes_service.prometheus.spec[0].port[0].node_port
  description = "NodePort for Prometheus"
}

output "prometheus_url" {
  value       = "http://localhost:${data.kubernetes_service.prometheus.spec[0].port[0].node_port}"
  description = "Prometheus access URL"
}

# Grafana outputs: NodePort and localhost URL
output "grafana_nodeport" {
  value       = data.kubernetes_service.grafana.spec[0].port[0].node_port
  description = "NodePort for Grafana"
}

output "grafana_url" {
  value       = "http://localhost:${data.kubernetes_service.grafana.spec[0].port[0].node_port}"
  description = "Grafana access URL"
}

# Argo CD outputs: admin password and port-forward command
output "argocd_admin_password" {
  value       = nonsensitive(data.kubernetes_secret.argocd_initial_password.data["password"])
  description = "Argo CD initial admin password"
}

output "argocd_port_forward" {
  value = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
}