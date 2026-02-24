🌐 GlobalSend Kubernetes GitOps Deployment - local lab
Automated Multi‑Environment Deployment | Helm, KIND, Terraform, Argo CD, Prometheus, Grafana  

Kubernetes | Helm | Terraform | ArgoCD | Prometheus | Grafana | KIND | GitHub Actions  

---

🚀 **Overview**  
GlobalSend Kubernetes GitOps Deployment provides a fully automated workflow for deploying the GlobalSend application in a local or cloud Kubernetes environment. The setup leverages KIND for local cluster provisioning, Terraform for infrastructure management, and Argo CD for GitOps-driven continuous delivery.  

The deployment includes monitoring via Prometheus and Grafana, enabling observability and metrics collection from all services. Helm charts are used for packaging and deploying both core application and monitoring components.  

**Highlights:**  
- Automated GitOps deployment of GlobalSend application  
- Local KIND cluster for development and testing  
- Integrated monitoring with Prometheus and Grafana  
- Reproducible infrastructure with Terraform  
- Automated Helm releases via Argo CD  
- NodePort services for local access  

---

🏗 **Architecture**  

**End‑to‑End Flow:**  
Local Development → GitHub → GitHub Actions → Terraform → KIND Cluster → Argo CD → Helm Charts → Prometheus/Grafana → GlobalSend App  

### Architecture Diagram
![Architecture Diagram](./assets/gitops.png)    



---

---
### Fraud Dashboard

![Fraud Dashboard](./assets/froudapps.png)     

---

---

⚡ **Key Components**  

| Component                 | Technology                          | Purpose |
|----------------------------|------------------------------------|---------|
| Local Cluster              | KIND                               | Provision local Kubernetes environment |
| Application Deployment     | Helm, Kubernetes                   | Deploy GlobalSend app in cluster |
| GitOps Automation          | Argo CD                            | Continuous deployment from Git repo |
| Monitoring & Metrics       | Prometheus, Grafana                | Collect and visualize metrics |
| Infrastructure as Code     | Terraform                          | Manage cluster resources and namespaces |
| CI/CD Pipeline             | GitHub Actions                     | Automate sync and deployments |
| Service Exposure           | NodePort / ClusterIP               | Access app and monitoring locally |

---

🔧 **Multi‑Environment Strategy**  

| Environment | Branch  | Deployment Trigger |
|-------------|---------|------------------|
| Development | dev     | Push to dev       |
| Staging     | staging | Merge dev → staging |
| Production  | main    | Merge staging → main via GitOps |

**Pipeline Features:**  
- Automatic environment detection from branch  
- Terraform provisioning of namespaces and cluster resources  
- Helm chart deployment with Argo CD  
- Automated monitoring stack deployment (Prometheus + Grafana)  
- NodePort exposure for local testing  

---

🗂 **Project Structure**  

```
🗂 globalsend-k8-gitops/
├── argocd/                   # Argo CD Application manifests
│   ├── application.yaml      # Argo CD Application resource
│   └── namespace.yaml        # Namespace manifest for Argo CD-managed resources
├── assets/                   # Documentation and reference images
├── helm/                     # Helm chart for GlobalSend application
│   └── globalsend/
│       ├── Chart.yaml        # Helm chart metadata
│       ├── values.yaml       # Default chart values
│       └── templates/        # Kubernetes manifests templates
│           ├── deployment.yaml  # Deployment spec for GlobalSend
│           └── service.yaml     # Service spec for GlobalSend
├── terraform/                # Terraform Infrastructure as Code
│   ├── main.tf               # Main configuration file
│   ├── providers.tf          # Terraform providers setup
│   ├── outputs.tf            # Output definitions
│   ├── variables.tf          # Input variable definitions
│   ├── prometheus.tf         # Prometheus monitoring stack
│   ├── gravana.tf            # Grafana monitoring stack
│   ├── argocd.tf             # Argo CD namespace and resources
│   ├── gitops-kind-config    # KIND cluster configuration
│   └── namespace.tf          # Cluster namespace definitions
└── README.md                 # Project documentation

```

---

🛡 **Security & Best Practices**  
- Environment Isolation: Separate namespaces for monitoring, Argo CD, and GlobalSend  
- GitOps Workflow: Argo CD ensures declarative, reproducible deployments  
- Helm Best Practices: Versioned charts and configurable values  
- Infrastructure Validation: Terraform ensures predictable cluster provisioning  

---

📝 **Usage**  

**Local Development**  

git clone <repo-url>
cd globalsend-k8-gitops
terraform init
terraform apply -auto-approve  # Creates KIND cluster, namespaces, monitoring
````

**Deploy Application via Argo CD**

* Ensure `globalsend` namespace exists
* Argo CD Application will sync Helm chart to cluster
* Monitor deployments in Argo CD UI

**Access Services**
* port-forward svc/argocd-server -n argocd 8080:443
* Prometheus: `kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090`
* Grafana: `kubectl port-forward svc/grafana -n monitoring 3000:80`
* GlobalSend App: ` kubectl port-forward svc/globalsend -n globalsend 8081:80                             `

---

👨‍💻 **Tech Stack**

* Kubernetes: KIND, Helm, Argo CD
* Monitoring: Prometheus, Grafana
* IaC: Terraform
* CI/CD: GitHub Actions
* Containerisation: Docker

---

📬 **Contact**
For questions about GitOps deployment or monitoring setup, contact the GlobalSend DevOps Team.

---

📜 **Licence**
MIT License
Last updated: February 2026

```
