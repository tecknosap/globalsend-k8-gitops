# Path to the kubeconfig file used by kubectl to connect to the cluster
variable "kubeconfig_path" {
  description = "Path to kubeconfig file for the target cluster"
  type        = string
  default     = "~/.kube/config"
}