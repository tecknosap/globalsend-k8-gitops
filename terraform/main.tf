########################
# Local Globalsend KIND cluster
# - 1 control-plane node, 1 worker node
# - Serves as the Kubernetes environment for GitOps
########################
resource "kind_cluster" "globalsend" {
  name           = "gitops-kind"
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
    }

    node {
      role = "worker"
    }
  }
}