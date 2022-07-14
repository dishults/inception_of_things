#!/bin/sh

GREEN="\033[32m"
NC="\033[0m" # No Color

NODE_IP=$(kubectl get nodes -o jsonpath="{.items[0].status.addresses[0].address}")
NODE_PORT=$(kubectl get services argocd-server -o jsonpath="{.spec.ports[0].nodePort}")
ARGOCD_SERVER=$NODE_IP:$NODE_PORT
ARGOCD_PASSWORD=$(kubectl get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)

echo "${GREEN}Argo CD API server is accessible at http://${ARGOCD_SERVER} ${NC}"
echo "username: admin, password: ${ARGOCD_PASSWORD}"

echo "\n${GREEN}Starting port forwarding for wil-playground app, it's accessible at: http://localhost:8888 ${NC}"
kubectl port-forward svc/wil-playground -n dev 8888:8888
