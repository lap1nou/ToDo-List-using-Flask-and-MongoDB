# ADVCL - Project Ansible vs K8s Operator

## Ansible - Install
Il faut d'abord configurer l'emplacement de la clé privé AWS ainsi que le host sur lequel lancer le `playbook` Ansible dans le fichier `hosts`.

Puis taper ces commandes pour lancer le `playbook`:
```
cd playbooks
ansible-playbook db.yml
```

Le site devrait être accessible sur : `http://$IP_ADDRESS:5000`.

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

Pour connaître le port il faut tpaer la commmande `kubectl get svc` et noter le port du service web, et l'adresse IP est celle du container KIND (si vous utilisez Minkube ca sera l'adresse IP du cluster).

Le site devrait être accessible sur : `http://$IP_ADDRESS:$PORT_SVC`.