## Module 3: Kubernetes Core Concepts

<https://github.com/cheruvu1/AKSWorkshop>

1. Kubectl - Imperative Approach
2. YAML - Declarative Approach
3. Pod
4. Service
5. ReplicaSet (Scaling Pods)
6. Deployment
7. Labels, Selectors & Annotations
8. Jobs and Cron Jobs
9. Multi-Container Pods and Init Containers

## 1. Kubectl - Imperative Approach

# Create Pod using command line

kubectl run webapp-pod --image=nginx

kubectl get pods webapp-pod --watch

kubectl get pods webapp-pod --output wide

# Create a Service using command line

kubectl create service clusterip my-cs --tcp=5678:8080

kubectl get services

# Create a Deployment using command line

kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1

kubectl get deployment

kubectl get rs

kubectl get pods

## 2. YAML - Declarative Approach

Refer the Module3A/dotnet-pod.yaml YAML file.

## 3. Pod

## 1.employee-producer - POD

cd lab

cd Module3A

kubectl apply -f service-employee-producer.yaml

kubectl get pods

kubectl logs employee-producer-pod

kubectl describe pod employee-producer-pod

## 2.employee-cert - POD

cd lab

cd Module3A

kubectl apply -f service-employee-cert.yaml

kubectl get pods

kubectl logs employee-cert-pod

kubectl describe pod employee-cert-pod

## 3.NET application - POD

cd lab

cd Module3A

kubectl apply -f dotnet-pod.yaml

kubectl get pods

kubectl logs dotnet-pod

kubectl describe pod dotnet-pod

## Future reference useful Pod Commands (Not for the lab exercise)

kubectl get pod label-demo -o=yaml

# List the Worker Node

kubectl get nodes

# create a new Pod from Yaml file

kubectl create –f service-employee-producer.yaml

# Update an existing Pod from Yaml file

kubectl apply –f service-employee-producer.yaml

# List the Pods that are currently running

kubectl get pods

# Connect inside the POD

kubectl apply –f service-employee-producer.yaml

# Describe the POD

kubectl describe  pod employee-producer-pod

# Check Logs

 kubectl logs employee-producer-pod

# Show Node and other Pod information

kubectl get pods –o wide

# Show YAML format

kubectl get pod  employee-producer-pod  -o json

kubectl get pod employee-producer-pod -o yaml

# List Pods from all Namespaces

kubectl get pods --all-namespaces

# List Pods by label app=myapp

kubectl get pods --all-namespaces -l app=myapp

# Connect inside the POD

kubectl exec --stdin --tty <POD NAME> -- /bin/bash

kubectl exec --stdin --tty dotnet-pod -- /bin/bash

# List the environment variables in the running container

kubectl exec <POD NAME> -- env

kubectl exec <POD NAME> -- ps aux

kubectl exec <POD NAME> -- ls /

kubectl exec <POD NAME> -- cat /proc/1/mounts

# Delete a POD

kubectl delete pod employee-producer-pod

## 4. Service

cd lab

cd Module3A

kubectl apply -f service-employee-producer.yaml

kubectl apply -f service-employee-cert.yaml

kubectl apply -f service-dotnet.yaml

kubectl get services

kubectl describe service service-employee-producer-pod

kubectl describe service service-cert-pod

kubectl describe service service-dotnet

## Test the Microservices

kubectl get services [Capture the Load Balancer IP#]

## DotNet

http://<LB IP>

## Employee Producer

http://<LB IP>:8000/employee

## Employee Cert

http://<LB IP>:9000/empcertifications

## 5. ReplicaSet (Scaling Pods)

cd lab

cd Module3A

kubectl delete pod employee-producer-pod

kubectl delete pod employee-cert-pod

kubectl apply -f replacaset-employee-producer.yaml

kubectl apply -f replacaset-employee-cert.yaml

kubectl get replicaset

kubectl get pods

kubectl delete pod employee-producer-replicaset-xxxx

kubectl get pods

## 6. Deploymen

cd lab
cd Module3A

kubectl delete rs employee-producer-replicaset

kubectl delete rs employee-cert-replicaset

kubectl get rs

kubectl get pods

kubectl apply -f deployment-employee-producer.yaml

kubectl apply -f deployment-employee-cert.yaml

kubectl get deployments

kubectl get rs

kubectl get pods

## To Delete a deployment (THIS SECTION IS INFORMATIONAL ONLY) - Not for the Lab Exercise 

kubectl delete deployment employee-producer-deployment

kubectl delete deployment employee-cert-deployment

## 7. Labels, Selectors & Annotations

cd lab

cd Module3A

kubectl create -f label-example.yaml

kubectl get pods --show-labels

kubectl get pods --selector=environment=production

kubectl apply -f annotations-example.yaml

## 8. Cron Jobs

kubectl apply -f cronjob-example.yaml

kubectl get cronjob hello

kubectl get jobs --watch

## 9. Multi-Container Pods and Init Containers
