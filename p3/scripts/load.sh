#!/bin/sh
# Source this file: . load.sh

GREEN="\033[32m"
NC="\033[0m" # No Color

export NODE_PORT=$(kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services argocd-server -n argocd)
export NODE_IP=$(kubectl get nodes -o jsonpath='{ $.items[*].status.addresses[?(@.type=="InternalIP")].address }')
export ARGOCD_SERVER=$NODE_IP:$NODE_PORT
export ARGOCD_OPTS="--plaintext --insecure"
echo "\n${GREEN}The Argo CD API server can be accessed at https://${ARGOCD_SERVER}${NC}"
echo "Username: 'admin', password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo)"