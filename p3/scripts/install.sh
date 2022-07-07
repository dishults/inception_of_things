#!/bin/sh

# Install requirements
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl

# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install kubectl
sudo snap install kubectl --classic

# Install K3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash