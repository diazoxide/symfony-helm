# Deploying Symfony to a Kubernetes Cluster

This repository contains a helm chart for deploying a Symfony application to a Kubernetes cluster.

# Features
1. PHP-FPM - as a main application container
2. Caddy - as a web server
3. Redis
4. PostgreSQL
5. Jobs
6. CronJobs
7. Migrations
8. Secrets
9. ConfigMaps
10. Persistent Volumes
11. Pod Autoscaling

# Setup and usage

## Add repository
First, add the repository to your helm:
```shell
helm repo add diazoxide https://raw.githubusercontent.com/diazoxide/symfony-helm/main
``` 

## Install chart
Then, install the chart:
```shell
helm upgrade --install symfony diazoxide/symfony --values values.yaml
```

# Development and contribution

To apply changes, commit them to the repository and get new version release by running:
```shell
#      Major Minor Patch
#           \  |  /
#            X.X.X
make VERSION=0.5.7 MESSAGE="Add Redis support" new-version
```
