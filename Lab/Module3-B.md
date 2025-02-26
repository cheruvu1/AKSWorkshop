
## Module 3B

## Kubernetes Core Concepts

1. Environment Variables
2. ConfigMap
3. Secrets
4. How to use Secrets and ConfigMap in Pods
5. Namespaces
6. Service Discovery
7. Deployment Rolling Update
8. Observability with  Readiness Probes
9. Observability with  Liveness Probes
10. Kubernetes Resources – Requests and Limits  

cd lab
cd Module3B

# 1. Environment Variables

kubectl apply -f Pod-Environment-Variable.yaml
kubectl describe pod payment-processing-pod-env
Note: Check the Environment: section

# 2. ConfigMap

kubectl apply -f AppConfigMap.yaml

kubectl get configmap
OR kubectl get cm

kubectl describe configmap payment-processing-config
kubectl apply -f Pod-AppConfigMap.yaml
kubectl describe pod payment-processing-pod-configmap
Note:

Environment Variables from:
      payment-processing-config  ConfigMap

# 3. Secrets

cd lab
cd Module3B

kubectl apply -f AppSecrets.yaml
kubectl get secrets

kubectl describe secrets oracle-database-secret
Note: Data is encrypted

## 4. How to use Secrets and ConfigMap in Pods

cd lab
cd Module3B

kubectl apply -f Pod-AppSecrets.yaml
kubectl get pods
kubectl describe pod frontend-pod-secret
Note:
Environment Variables from:
      oracle-database-secret  Secret

## 5 Namespaces

cd lab
cd Module3B
cd Namespace

kubectl apply -f namespace-sales.yaml
kubectl apply -f namespace-marketing.yaml

kubectl get ns OR kubectl get namespace

kubectl get all -n marketing
kubectl get all -n sales

kubectl apply -f pod-employee-producer.yaml
kubectl apply -f pod-employee-cert.yaml

kubectl get pods -n sales
kubectl get pods -n marketing
kubectl apply -f service-employee-cert.yaml
kubectl apply -f service-employee-producer.yaml

kubectl get services -n sales
kubectl get services -n marketing
kubectl get all -n sales
kubectl get all -n marketing

## 6. Service Discovery

# Exercise 1

kubectl get pods -n marketing
kubectl exec -it employee-producer-marketing -n marketing -- bash

root@employee-producer-marketing:/#  <run below command>

curl <http://service-cert-pod.sales.svc.cluster.local:9000/empcertifications>

## OUTPUT

{"empId":"36975","certId":"AZ-204","certification":"Developing Solutions for Microsoft Azure","dateCompletion":"01/01/2023"}

Run the exit command
root@employee-producer-marketing:/#   exit

# Exercise 2

kubectl get pods -n sales
kubectl exec -it employee-cert-pod -n sales -- bash

root@employee-cert-pod:/# <run below command>

curl <http://service-employee-producer-pod.marketing.svc.cluster.local:8000/employee>

## OUTPUT

{"empId":"36975","name":"David Lee","designation":"Cloud Architect","address":"One Microsoft Way, Redmond, Washington, 98052-6399, USA","salary":7000.0}

Run the exit command
root@employee-cert-pod:/# exit

## 7. Deployment Rolling Update

cd AKSWorkshop/Lab/Module3B/RollingUpdate

1. kubectl apply -f RollingUpdate-Deployment.yaml
2. kubectl get pods | grep -i 'echo'
3. Open the file RollingUpdate-Deployment.yaml    
   Line# 32: Change Image
   from image: azurecloud1/employee-producer:v1.0.0

   To azurecloud1/employee-producer:v2.0.0

4. kubectl apply -f RollingUpdate-Deployment.yaml
5. kubectl get pods | grep -i 'echo

## 8. Observability with  Readiness Probes &  

## 9. Observability with  Liveness Probes

cd lab
cd Module3B
cd Observability
Review readinessProbe.yaml
Review livenessProbe.yaml

## 10. Kubernetes Resources – Requests and Limits  

cd lab
cd Module3B
cd ResourceLimits

kubectl apply -f namespace-resourcelimit.yaml
kubectl apply -f employee-cert-pod.yaml
kubectl get all -n resourcelimit
kubectl describe pod employee-cert-pod -n resourcelimit
Note: Review Limits and Requests CPU and Memory
