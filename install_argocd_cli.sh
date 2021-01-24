#!/bin/bash
## Check  https://argoproj.github.io/argo-cd/cli_installation/
## For latest version and install instructions

mkdir -p /usr/local/bin/
VERSION=1.8.3
curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/${VERSION}/argocd-linux-amd64
if [ $? -eq 0 ]; then
    chmod +x /usr/local/bin/argocd
fi