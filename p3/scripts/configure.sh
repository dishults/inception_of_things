#!/bin/sh

GREEN="\033[32m"
NC="\033[0m" # No Color

echo "${GREEN}Creating a cluster${NC}"
k3d cluster create inception-of-things --agents 2 -p 8080:30080@agent:0 -p 8888:30088@agent:1 --wait

echo "\n${GREEN}Creating two namespaces${NC}"
kubectl create namespace argocd
kubectl create namespace dev

echo "\n${GREEN}Setting current context default namespace to Argo CD${NC}"
kubectl config set-context --current --namespace=argocd

echo "\n${GREEN}Installing Argo CD${NC}"
kubectl apply -f ../confs/argo_cd.yaml --wait

echo "\n${GREEN}Waiting for Argo CD pods to finish initializing${NC}"
for pod in $(kubectl get deploy -o name); do kubectl rollout status $pod --timeout 0; done

echo "\n${GREEN}Logging in to Argo CD${NC}"
ARGOCD_PASSWORD=$(kubectl get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)
argocd login localhost:8080 --plaintext --insecure --username admin --password $ARGOCD_PASSWORD

echo "\n${GREEN}Creating development project${NC}"
kubectl apply -f ../confs/argo_cd_project.yaml --wait

echo "\n${GREEN}Creating wil-playground app${NC}"
kubectl apply -f ../confs/wil_playground.yaml --wait

echo "\n${GREEN}Removing app's annotations${NC}"
kubectl replace -f ../confs/wil_playground.yaml --wait
