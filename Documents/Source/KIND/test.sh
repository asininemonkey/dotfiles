#!/usr/bin/env zsh

kind \
  create cluster \
    --config "test.yaml" \
    --kubeconfig "${HOME}/.kube/kind/test"
