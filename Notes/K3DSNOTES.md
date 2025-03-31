# Star t

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

# ArgoCD

curl -L https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -o argocd-install.yaml
kubectl apply -n argocd -f ArgoSetup/argocd-install.yaml
kubectl patch svc argocd-server -n argocd --type=merge --patch-file=ArgoSetup/argocd-setup.yaml

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

kubectl apply -f ArgoSetup/argo-app.yaml
kubectl rollout status deployment liatrio-deployment-api -n dev

argocd admin initial-password -n argocd
argocd login localhost:8080 --username admin --insecure
argocd account update-password

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

# ArgoCD Image Updater

curl -L https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml -o ArgoSetup/argocd-image-install.yaml
kubectl apply -n argocd -f ArgoSetup/argocd-image-install.yaml

# Argo CD Image

kubectl -n argocd create secret generic git-deploy-key \
 --from-file=sshPrivateKey=./argocd-image-updater

argocd repo add git@github.com:Solarleaf/liatrio-apprentice.git \
 --ssh-private-key-path ./argocd-image-updater

kubectl create secret generic git-ssh-key \
 --from-file=sshPrivateKey=/path/to/your/private/key \
 -n argocd

kubectl create secret generic argocd-repo-creds \
 --from-literal=username=$(echo -n "Solarleif" | base64) \
  --from-literal=password=$(echo -n "your_personal_access_token" | base64) \
 -n argocd

# Helm

if command -v helm &> /dev/null; then echo "Helm is already installed $(helm version)"; else
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm -f get_helm.sh
fi
