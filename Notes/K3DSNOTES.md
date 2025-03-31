# Start

k3d cluster create cluster-1

k3d cluster create --config ArgoSetup/k3d-cluster.yaml

# Kubectl

if ! command -v kubectl &> /dev/null; then
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo "✅ kubectl installed: $(kubectl version --client --short)"
else
  echo "✅ kubectl is already installed:"
  echo"n$(kubectl version)"
fi

kubectl create namespace argocd

# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

curl -L https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -o argocd-install.yaml
kubectl apply -n argocd -f ArgoSetup/argocd-install.yaml
kubectl patch svc argocd-server -n argocd --type=merge --patch-file=ArgoSetup/argocd-setup.yaml

curl -L https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml -o argocd-image-install.yaml
kubectl apply -n argocd -f ArgoSetup/argocd-image-install.yaml

# Check if Argo CD CLI exists and runs successfully

if ! which argocd >/dev/null 2>&1 || ! argocd version --client >/dev/null 2>&1; then
echo "🔧 Argo CD CLI not found or broken — installing..."
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
echo "✅ Argo CD CLI installed successfully."
else
echo "✅ Argo CD CLI is already installed and working:"
echo "$(argocd version --client --short)"
fi

argocd admin initial-password -n argocd
argocd login localhost:8080 --username admin --insecure
argocd account update-password

kubectl apply -f ArgoSetup/argo-app.yaml

# Kill Cluster

k3d cluster delete cluster-1

# Port forwarding

kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl port-forward svc/liatrio-service-api -n default 8081:8081

Jobs
Kill %1

gitops-repo/
├── clusters/
│ ├── dev/
│ │ ├── apps.yaml
│ │ └── infrastructure.yaml
│ ├── staging/
│ │ ├── apps.yaml
│ │ └── infrastructure.yaml
│ └── production/
│ ├── apps.yaml
│ └── infrastructure.yaml

# Apps

ArgoCD Application Manifest files.

- Repo, branch, location
- Destination (https://kubernetes.default.svc internal same cluster or external)

# infrastructure

- Namespaces, RBAC, storage, network policies

├── apps/
│ ├── app1/
│ │ ├── deployment.yaml
│ │ ├── service.yaml
│ │ ├── ingress.yaml
│ │ └── kustomization.yaml
│ └── app2/
│ ├── helm-chart/
│ │ ├── Chart.yaml
│ │ └── values.yaml
│ └── kustomization.yaml
│
├── infrastructure/
│ ├── namespaces.yaml
│ ├── rbac.yaml
│ └── storage.yaml
│
└── base/
├── common-labels.yaml
└── kustomization.yaml
