#!/bin/sh

GREEN="\033[32m"
NC="\033[0m" # No Color

echo "${GREEN}Installing requirements${NC}"
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl

echo "\n${GREEN}Installing docker${NC}"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm -rf get-docker.sh

echo "\n${GREEN}Installing kubectl${NC}"
sudo snap install kubectl --channel=1.24/stable --classic

echo "\n${GREEN}Installing K3d${NC}"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | TAG=v5.4.4 bash

echo "\n${GREEN}Installing Argo CD CLI${NC}"
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.4.6/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd

echo "\n${GREEN}Installing bash completions for kubectl, k3d and argocd${NC}"
echo "source <(kubectl completion bash)
source <(k3d completion bash)
source <(argocd completion bash)" >>~/.bashrc

echo "\n${GREEN}Configuring docker for a non-root user${NC}"
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
