
#!/usr/bin/env bash

kubectl -n argo port-forward svc/argo-server 2746:2746 
