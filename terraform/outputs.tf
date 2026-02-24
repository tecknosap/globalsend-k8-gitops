########################
# Outputs for Prometheus access
# - NodePort number
# - Full URL for localhost access
########################
output "prometheus_nodeport" {
  value       = data.kubernetes_service.prometheus.spec[0].port[0].node_port
  description = "NodePort for accessing Prometheus"
}

output "prometheus_url" {
  value       = "http://localhost:${data.kubernetes_service.prometheus.spec[0].port[0].node_port}"
  description = "URL to access Prometheus"
}

########################
# Outputs for Grafana access
# - NodePort number
# - Full URL for localhost access
########################
output "grafana_nodeport" {
  value       = data.kubernetes_service.grafana.spec[0].port[0].node_port
  description = "NodePort for accessing Grafana"
}

output "grafana_url" {
  value       = "http://localhost:${data.kubernetes_service.grafana.spec[0].port[0].node_port}"
  description = "URL to access Grafana"
}


########################
# Outputs for Argo CD access
# - Admin password (nonsensitive to avoid marking as secret)
# - Example kubectl port-forward command to access the UI
########################
output "argocd_admin_password" {
  value       = nonsensitive(data.kubernetes_secret.argocd_initial_password.data["password"])
  description = "Argo CD initial admin password"
}

output "argocd_port_forward" {
  value = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
}