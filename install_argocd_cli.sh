#!/bin/bash -x
## Check  https://argoproj.github.io/argo-cd/cli_installation/
## For latest version and install instructions

mkdir -p /usr/local/bin/
VERSION=v1.8.3
#curl -sSL -v -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/${VERSION}/argocd-linux-amd64
wget https://github.com/argoproj/argo-cd/releases/download/${VERSION}/argocd-linux-amd64
if [ $? -eq 0 ]; then
    mv argocd-linux-amd64 /usr/local/bin/argocd
    chmod +x /usr/local/bin/argocd
fi