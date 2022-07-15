#!/bin/sh

GREEN="\033[32m"
NC="\033[0m" # No Color

ARGOCD_PASSWORD=$(kubectl get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)
echo "${GREEN}Argo CD: http://localhost:8080 ${NC}"
echo "username: admin, password: ${ARGOCD_PASSWORD}"

echo "\n${GREEN}wil-playground: http://localhost:8888 ${NC}"
