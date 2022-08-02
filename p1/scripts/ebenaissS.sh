#!/bin/bash

### https://stackoverflow.com/questions/65995056/kubernetes-api-server-bind-address-vs-advertise-address
export INSTALL_K3S_EXEC="server --write-kubeconfig-mode=644 --node-ip $1 --bind-address=$1"
curl -sfL https://get.k3s.io |  sh -

## pour rendre disponible le token aux agents
#sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/scripts/
mkdir -p /root/.ssh
cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys

## pour rendre disponible la commande 'ifconfig' durant la correction, la commande 'ip' présente de base aurait suffit...
#sudo yum install net-tools -y

## pour désinstaller
# /usr/local/bin/k3s-uninstall.sh
