#!/bin/bash -x
## Check  https://argoproj.github.io/argo-cd/cli_installation/
## For latest version and install instructions

VERSION=v1.8.3
curl -sSL -v -o /tmp/argocd https://github.com/argoproj/argo-cd/releases/download/${VERSION}/argocd-linux-amd64
#wget https://github.com/argoproj/argo-cd/releases/download/${VERSION}/argocd-linux-amd64
if [ $? -eq 0 ]; then
    #mv argocd-linux-amd64 /tmp/argocd
    chmod +x /tmp/argocd
fi