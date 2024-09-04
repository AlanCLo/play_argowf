#!/usr/bin/env bash

kubectl create secret generic argo-artifacts \
    --from-literal=accesskey=lyVXuNlBXadwbHt9 \
    --from-literal=secretkey=BWFxwH8SYbL7SztUytgb55NnGluG6aTp \
    -n argo