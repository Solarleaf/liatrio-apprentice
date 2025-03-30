# Argo CD

kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Yaml File: Get the file from ^ above or:

curl -L https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -o k8s/argocd-install.yaml


kubectl apply -n argocd -f ArgoCD/argocd-install.yaml


kubectl apply -n argocd -f ArgoCD/argocd-namespace.yaml



# ArgoCD CLI

curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64

sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd

rm argocd-linux-amd64


# Access Argo CD API Server:

Temp: 

Alraedy using 8080 so using 9999

kubectl port-forward svc/argocd-server -n argocd 9999:443



Load balancer:

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'









# Argo CD
kubectl create namespace argocd
Or:
apiVersion: v1
kind: Namespace
metadata:
  name: argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
Yaml File: Get the file from ^ above or:
curl -L https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -o k8s/argocd-install.yaml
kubectl apply -n argocd -f ArgoCD/argocd-install.yaml
kubectl apply -n argocd -f ArgoCD/argocd-namespace.yaml

# ArgoCD CLI
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Access Argo CD API Server:

Temp: 
Alraedy using 8080 so using 9999
kubectl port-forward svc/argocd-server -n argocd 9999:443

Load balancer:
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'


kubectl port-forward svc/argocd-server -n argocd 9999:443