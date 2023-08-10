# Deploying Symfony to a Kubernetes Cluster


## Add repository
```shell
helm repo add diazoxide https://raw.githubusercontent.com/diazoxide/symfony-helm/main
``` 

## Install chart
```shell
helm upgrade --install symfony diazoxide/symfony-helm --values values.yaml
```