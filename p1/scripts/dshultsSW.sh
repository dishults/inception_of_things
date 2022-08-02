#!/bin/bash

## récupération du token k3s du master
mkdir -p /root/.ssh
mv /tmp/id_rsa /root/.ssh
scp -o StrictHostKeyChecking=no root@192.168.42.110:/var/lib/rancher/k3s/server/token /tmp/token

export INSTALL_K3S_EXEC="agent --server https://$1:6443 --token-file /tmp/token --node-ip=$2"
curl -sfL https://get.k3s.io | sh -

# sudo yum install net-tools -y

## pour désinstaller
# /usr/local/bin/k3s-uninstall.sh
