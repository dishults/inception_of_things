#!/bin/sh

GREEN="\033[32m"
NC="\033[0m" # No Color

echo "${GREEN}Installing requirements${NC}"
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl

echo "\n${GREEN}Installing docker${NC}"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "\n${GREEN}Installing kubectl${NC}"
sudo snap install kubectl --classic

echo "\n${GREEN}Installing K3d${NC}"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash