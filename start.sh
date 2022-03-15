#!/bin/bash

kind create cluster --config=k8s/kind.yaml --name=fullcycle
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

kubectl apply -f k8s/namespaces/
kubectl config set-context dev --namespace=dev --cluster=kind-fullcycle --user=kind-fullcycle
kubectl config use-context dev
kubectl apply -f k8s/
