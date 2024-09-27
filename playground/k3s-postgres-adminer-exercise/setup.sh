#!/bin/sh
kubectl apply -f /vagrant/postgres/pg-configmap.yaml
kubectl apply -f /vagrant/postgres/pg-secret.yaml
kubectl apply -f /vagrant/postgres/pg.yaml
kubectl apply -f /vagrant/adminer/adminer.yaml
kubectl apply -f /vagrant/adminer/adminer-ingress.yaml