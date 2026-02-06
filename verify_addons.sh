#!/bin/bash
set -e

CLUSTER_NAME="eks-platform-prod-v2-cluster"
REGION=" ap-southeast-2"

echo "--------------------------------------------------------"
echo "Verifying Addons for Cluster: $CLUSTER_NAME"
echo "--------------------------------------------------------"

# 1. Connect to Cluster
echo "Updating Kubeconfig..."
aws eks update-kubeconfig --name "$CLUSTER_NAME" --region "$REGION"

# Function to check deployment status
check_namespace() {
    NS=$1
    echo ""
    echo ">>> Checking Namespace: $NS"
    kubectl get pods -n "$NS"
    
    echo ">>> Services in $NS:"
    kubectl get svc -n "$NS"
}

# 2. Check Nginx Ingress
check_namespace "ingress-nginx"
echo ">>> Nginx LoadBalancer URL:"
kubectl get svc -n ingress-nginx ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' || echo "Not found"
echo ""

# 3. Check ArgoCD
check_namespace "argocd"
echo ">>> ArgoCD Server URL (LoadBalancer if enabled, or use Port Forward):"
kubectl get svc -n argocd argocd-server || echo "Not found"

# 4. Check Vault
check_namespace "vault"

# 5. Check SonarQube
check_namespace "sonarqube"

echo ""
echo "--------------------------------------------------------"
echo "Verification Complete."
