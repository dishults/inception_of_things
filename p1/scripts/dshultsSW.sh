#!/bin/bash

export INSTALL_K3S_EXEC="agent --server https://$1:6443 --token-file /vagrant/scripts/node-token --node-ip=$2"
curl -sfL https://get.k3s.io | sh -

sudo yum install net-tools -y

## pour désinstaller
# /usr/local/bin/k3s-uninstall.sh
