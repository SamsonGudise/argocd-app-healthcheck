#!/bin/bash
## Check  https://argoproj.github.io/argo-cd/cli_installation/
## For latest version and install instructions

VERSION=$1
curl -sSL -o /tmp/argocd https://github.com/argoproj/argo-cd/releases/download/${VERSION}/argocd-linux-amd64
if [ $? -eq 0 ]; then
    chmod +x /tmp/argocd
fi