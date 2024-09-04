#!/usr/bin/env bash

kubectl -n argo port-forward svc/minio-service 9000:9000 9001:9001
