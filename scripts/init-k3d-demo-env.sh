#!/bin/bash
MYDIR=$(dirname $0)
k3d cluster delete cf-crossplane-vcluster-demo
k3d cluster create cf-crossplane-vcluster-demo
k3d kubeconfig get cf-crossplane-vcluster-demo > /tmp/k3d-cf-crossplane-vcluster-demo.config
export KUBECONFIG=/tmp/k3d-cf-crossplane-vcluster-demo.config
helm repo add argo https://argoproj.github.io/argo-helm && helm repo update
helm install --repo https://argoproj.github.io/argo-helm --create-namespace --namespace argocd argocd argo-cd --version 5.21.0  --set "configs.cm.application\.resourceTrackingMethod=annotation" --wait
kubectl -n argocd apply -f $MYDIR/../argocd-applications