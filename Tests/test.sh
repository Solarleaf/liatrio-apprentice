#!/bin/bash
set -e

echo "⏳ Waiting for pod to be ready..."
kubectl wait --for=condition=Ready pod -l app=liatrio-app-api --timeout=60s

echo "🚀 Pod is ready. Running curl test from inside the cluster..."
kubectl run curlpod --rm -i --tty --image=curlimages/curl --restart=Never -- \
  curl -s http://liatrio-service-api:8080

echo "✅ Curl test passed!"
