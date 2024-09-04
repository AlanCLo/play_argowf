# play_argowf notes

References

* https://pipekit.io/blog/argo-workflows-with-docker-desktop
* https://argo-workflows.readthedocs.io/en/latest/configure-artifact-repository/
* https://min.io/docs/minio/kubernetes/upstream/index.html
* https://dev.to/olgabraginskaya/unleash-your-pipeline-creativity-local-development-with-argo-workflows-and-minio-on-minikube-2764


```bash
# get cli
brew install argo

# create agro and web ui
kubectl create ns argo
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.4.5/install.yaml

# port forward to see web ui
# or ./port-forward.sh
kubectl -n argo port-forward svc/argo-server 2746:2746 

# create SA / access via k8s objects
# notes that regular k8s api access is required too. add to the yaml
# https://argo-workflows.readthedocs.io/en/latest/security/
kubectl create -f setup/argo_access_kube.yaml

# get token
# `source ./get_argo_token.sh`
SECRET=$(kubectl get sa argooperator -n argo -o=jsonpath='{.secrets[0].name}')
ARGO_TOKEN="Bearer $(kubectl get secret $SECRET -n argo -o=jsonpath='{.data.token}' | base64 --decode)"
echo $ARGO_TOKEN

argo submit -n argo --watch hello-world.yaml 

# https://dev.to/olgabraginskaya/unleash-your-pipeline-creativity-local-development-with-argo-workflows-and-minio-on-minikube-2764

## CHANGE minio-dev-clusterip.yaml volume path
kubectl apply -f setup/minio-dev-clusterip.yaml

## port forwards

# default user/pass minioadmin:minioadmin
# Use UI to
# - create key
# - create bucket "argo-bucket"

kubectl create secret generic argo-artifacts \
    --from-literal=accesskey=(minio key) \
    --from-literal=secretkey=(minio secret) \
    -n argo


kubectl apply -f setup/artifact-repositories.yaml

argo submit -n argo --serviceaccount argo --watch workflows/simple-passing.yaml 

```