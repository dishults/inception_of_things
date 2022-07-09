#!/bin/sh
# Source this file: . load.sh

GREEN="\033[32m"
NC="\033[0m" # No Color

echo "\n${GREEN}Running port forwarding. The Argo CD API server can be accessed at http://127.0.0.1:8080${NC}"
echo "Username: admin, password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo)"
kubectl port-forward svc/argocd-server -n argocd 8080:443
