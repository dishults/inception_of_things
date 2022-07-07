#!/bin/sh

# Configure docker for a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 

# Create a cluster with 2 worker nodes
k3d cluster create my-cluster --api-port 6443 -p 8080:80@loadbalancer --agents 2

# Create two namespaces
kubectl create namespace argocd
kubectl create namespace dev

# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
