#!/bin/sh

GREEN="\033[32m"
NC="\033[0m" # No Color

echo "${GREEN}Creating a cluster${NC}"
k3d cluster create inception-of-things --wait

echo "\n${GREEN}Creating two namespaces${NC}"
kubectl create namespace argocd
kubectl create namespace dev

echo "\n${GREEN}Setting current context default namespace to Argo CD${NC}"
kubectl config set-context --current --namespace=argocd

echo "\n${GREEN}Installing Argo CD${NC}"
kubectl apply -f ../confs/install.yaml --wait

echo "\n${GREEN}Waiting for Argo CD pods to finish initializing${NC}"
for pod in $(kubectl get deploy -o name); do kubectl rollout status $pod; done

echo "\n${GREEN}Logging in to Argo CD${NC}"
NODE_PORT=$(kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services argocd-server -n argocd)
NODE_IP=$(kubectl get nodes -o jsonpath='{ $.items[*].status.addresses[?(@.type=="InternalIP")].address }')
ARGOCD_SERVER=$NODE_IP:$NODE_PORT
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo)
argocd login $ARGOCD_SERVER --plaintext --insecure --username admin --password $ARGOCD_PASSWORD

echo "\n${GREEN}Creating wil-playground app${NC}"
kubectl apply -f ../confs/application.yaml --wait
