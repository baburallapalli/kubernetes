#!/bin/sh

export NAMESPACE=shared-ingress

kubectl delete namespace $NAMESPACE --ignore-not-found=true --now=true

# wait to delete resources
sleep 60

kubectl create namespace $NAMESPACE

#wait to avoid issues with uncreated namespace
sleep 10

kubectl create sa oraclebmc-provisioner -n=$NAMESPACE

kubectl create -f https://raw.githubusercontent.com/baburallapalli/kubernetes/master/ingress/nginx-default-backend-deployment.yaml -n=$NAMESPACE

kubectl create -f https://raw.githubusercontent.com/baburallapalli/kubernetes/master/ingress/nginx-default-backend-service.yaml -n=$NAMESPACE

kubectl create -f https://raw.githubusercontent.com/baburallapalli/kubernetes/master/ingress/nginx-ingress-controller-deployment.yaml -n=$NAMESPACE

kubectl create -f https://raw.githubusercontent.com/baburallapalli/kubernetes/master/ingress/nginx-ingress-controller-service.yaml -n=$NAMESPACE
