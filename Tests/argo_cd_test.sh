#!/bin/bash
set -e

echo "Waiting for pod to be ready"
kubectl wait --for=condition=Ready pod -l app=liatrio-app-api --timeout=60s
echo ""

echo "Currling localhost"
curl http://localhost:8081
echo ""

echo "Running curl test from inside the cluster."
kubectl run curlpod --rm -i --image=curlimages/curl --restart=Never -- \
  curl -s http://liatrio-service-api:8081

echo ""

echo "Curl test passed!"
