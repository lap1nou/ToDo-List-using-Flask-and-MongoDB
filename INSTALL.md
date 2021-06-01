# ADVCL - Project Ansible vs K8s Operator

## Ansible - Install

## K8s Operator - Install
Créez le cluster:
```
kind create cluster
```

et le namespace pour Mongodb:
```
kubectl create namespace mongodb
```

Faite que namespace `mongodb`, soit le namespace par défaut :
```
kubectl config set-context $(kubectl config current-context) --namespace=mongodb
```

Installez l'opérateur MongoDB de K8s :
```
kubectl apply -f mongodb-kubernetes-operator-master/config/crd/bases/mongodbcommunity.mongodb.com_mongodbcommunity.yaml
kubectl apply -k mongodb-kubernetes-operator-master/config/rbac/
kubectl create -f mongodb-kubernetes-operator-master/config/manager/manager.yaml
```

Appliquez la configuration MongoDB:
```
kubectl apply -f mongodb-kubernetes-operator-master/config/samples/mongodb.com_v1_mongodbcommunity_cr.yaml
```

Deployez le service et les pods de l'application web:
```
kubectl create -f k8s/deployment.yaml
kubectl create -f k8s/service.yaml
```

L'image Docker se trouve à cette adresse: https://hub.docker.com/repository/docker/lapinou1234/todo