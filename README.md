# GOV.UK on Kubernetes

This is a spike repo into running GOV.UK on Kubernetes, mostly as a way of learning how Kubernetes works.

## Setup

1. [Docker Edge for Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac) with Kubernetes enabled.
2. The [Helm](https://github.com/kubernetes/helm) tiller installed in the cluster, with the `helm` cli installed on your laptop
3. The NGINX Ingress controller:
```
helm install stable/nginx-ingress
```
4. A MongoDB instance:
```
helm install --name govuk stable/mongodb
```
5. Apply the resources in this repo to the cluster
```
kubectl apply -Rf .
```
6. Import Content Store mongodb data:
```
./import_mongo.sh /Users/paulbowsher/code/govuk-puppet/development-vm/replication/backups/2018-01-03/mongo/api-mongo-1.api.integration/2018-01-03_06h46m.Wednesday/content_store_production content_store
```

Visit http://government-frontend.127.0.0.1.nip.io/government/publications/autumn-budget-2017-documents

## Supported services

- Content Store
- Government Frontend
- Static

## TODO

- Publishing API
