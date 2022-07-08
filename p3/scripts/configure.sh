#!/bin/sh

GREEN="\033[32m"
NC="\033[0m" # No Color

echo "${GREEN}Configuring docker for a non-root user${NC}"
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 

echo "\n${GREEN}Creating a cluster${NC}"
k3d cluster create inception-of-things

echo "\n${GREEN}Creating two namespaces${NC}"
kubectl create namespace argocd
kubectl create namespace dev

echo "\n${GREEN}Installing Argo CD${NC}"
kubectl apply -f ../confs/install.yaml -n argocd

echo "\n${GREEN}Installing Argo CD CLI${NC}"
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd

echo "\n${GREEN}Exposing the Argo CD API server${NC}"
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'