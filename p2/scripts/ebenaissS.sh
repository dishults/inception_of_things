#!/bin/bash

export INSTALL_K3S_EXEC="server --write-kubeconfig-mode=644 --node-ip $1"
curl -sfL https://get.k3s.io |  sh -

sudo yum install net-tools -y
