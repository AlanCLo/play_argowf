#!/usr/bin/env bash

SECRET=$(kubectl get sa argooperator -n argo -o=jsonpath='{.secrets[0].name}')
export ARGO_TOKEN="Bearer $(kubectl get secret $SECRET -n argo -o=jsonpath='{.data.token}' | base64 --decode)"
echo $ARGO_TOKEN
echo "Token is in your clipboard"
echo $ARGO_TOKEN | pbcopy