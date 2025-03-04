## Module 3: Kubernetes Core Concepts

<https://github.com/cheruvu1/AKSWorkshop>

1. Kubectl - Imperative Approach
2. YAML - Declarative Approach
3. Pod
4. Service
5. ReplicaSet (Scaling Pods)
6. Deployment
7. Labels, Selectors & Annotations
8. Cron Jobs
9. Multi-Container Pods and Init Containers

cd AKSWorkshop

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

kubectl apply -f employee-producer-pod.yaml

kubectl get pods

kubectl logs employee-producer-pod

kubectl describe pod employee-producer-pod

## 2.employee-cert - POD

cd lab

cd Module3A

kubectl apply -f employee-cert-pod.yaml

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

http://YOUR LOADBALANCER IP

## Employee Producer

http://YOUR LOADBALANCER IP:8000/employee

## Employee Cert

http://YOUR LOADBALANCER IP:9000/empcertifications

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

## 6. Deployment

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
