#!/bin/bash
export INSTALL_K3S_EXEC="server --write-kubeconfig-mode=644 --node-ip $1 --bind-address=$1"
curl -sfL https://get.k3s.io |  sh -

/usr/local/bin/kubectl -n kube-system apply -f /vagrant/confs

#pour voir l'ingress on utilise kubectl en précisant le namespace qui va bien : kubectl get ingress -n kube-system
#sinon : kubectl get all -n kube-system permet de voir le reste