# Deploying Symfony to a Kubernetes Cluster

# Setup and usage

## Add repository
```shell
helm repo add diazoxide https://raw.githubusercontent.com/diazoxide/symfony-helm/main
``` 

## Install chart
```shell
helm upgrade --install symfony diazoxide/symfony-helm --values values.yaml
```

# Development

To apply changes and commit them to the repository, run:
```shell
#      Major Minor Patch
#           \  |  /
#            X.X.X
make VERSION=0.5.7 new-version
```
