
## State Persistence

1. Persistent Volumes
2. Persistent Volume Claims
3. How to use PVC in a Pod
4. Storage Classes
5. NetworkPolicy
6. Ingress Controller - Path based routing.

## 1. Persistent Volumes  & ## 3. Persistent Volume Claims & ## 4. How to use PVC in a Pod

# CSI File Drivers: <https://learn.microsoft.com/en-us/azure/aks/azure-files-csi>

# src: <https://docs.microsoft.com/en-us/azure/aks/azure-files-volume>

## Static Provisioning Demo Steps

## Note: This Lab assume that you already created an AKS Cluster

cd AKSWorkshop/Lab/Module4/Persistence/Static-Provisioning

1. Go to --> Azure Portal --> Resource Groups --> Capture the Resource Group Name for your MC AKS cluster

MC_aksworkshopRG_aksworkshopcluster_usgovvirginia

2. Go to --> Azure Portal --> Storage Account -- > Create a new Storage Account

Name: staticstorageaccount

RG: MC_aksworkshopRG_aksworkshopcluster_usgovvirginia

Select all the default sections and click on Review + Create

3. Go to --> Storage Account --> staticstorageaccount

Expand Data storage --> File Shares --> + File Share --> static-file-share

click on Review + Create

click on Create

4. Security + Networking --> Access Keys --> Capture

5. Ask instructor for the Secret Command

6. kubectl create secret generic azure-secret 
--from-literal=azurestorageaccountname=staticstorageaccount  
--from-literal=azurestorageaccountkey=<Replace with your key>

kubectl get secrets

Note: Make sure azure-secret created successfully

6. cd AKSWorkshop/Lab/Module4/Persistence/Static-Provisioning

kubectl apply -f azure-file-pv.yaml

kubectl get pv

7.

kubectl apply -f azure-file-pvc.yaml

    persistentvolumeclaim/azurefile created

kubectl get pvc

Note: Status: Bound

Volume: azurefile

kubectl pv

Note: Status: Bound

CLAIM set to default/azurefile

8.

kubectl apply -f app-pod.yaml

kubectl get pods

kubectl describe pod mypod

Note:

Mounts:
      /mnt/azure from azure (rw)

9. kubectl exec pod/mypod -it -- /bin/sh

   From inside the Pod shell

   ls /mnt/azure

   echo "Hello from Azure File Share-Static-Provisioning sharing - Pod" > /mnt/azure/StaticShare.txt

   ls /mnt/azure

   cat /mnt/azure/StaticShare.txt

10. Azure Protal --> Data storage -->

File Shares --> + File Share --> static-file-share --> Browse

You will see the StaticShare.txt file created by the Pod.

11. Click on ... (3 dots next to the StaticShare.txt)

Edit --> Hello from Azure Portal Storage Account --> Save

12. kubectl exec pod/mypod -it -- /bin/sh

cat /mnt/azure/StaticShare.txt

## 4. Storage Classes

## Dynamic Provisioning

cd AKSWorkshop/Lab/Module4/Persistence/Dynamic-Provisioning

# Deploy the Storage Class and PVC to create the Storage Account & File Share

# Dynamically create the Azure Storage Account instead of manually creating it

1. kubectl apply -f azure-file-sc.yaml

   storageclass.storage.k8s.io/my-azurefile created

2. kubectl get storageclass

   kubectl describe sc my-azurefile

3. kubectl apply -f azure-file-pvc.yaml

   persistentvolumeclaim/my-azurefile created

4. kubectl get pvc

5. Goto -->

Azure Portal --> RG: MC_aksworkshopRG_aksworkshopcluster_usgovvirginia

--> Storage Account --> <Storage Account Name>

6. File shares --> pod-file-share --> Browse --> Empty

7. For your Pod to get access to the File shares --> It need permission/access

   Security + networking --> Access Keys

8. Storage Account automatically create the secret for you,

  kubectl get secrets --> azure-storage-account-secret

  kubectl describe secret azure-storage-account--secret

9. kubectl get secret azure-storage-account-secret -o yaml

10. kubectl apply -f app-pod.yaml

    kubectl get pods

    kubectl get pv (Note: Persistent Volume Automatically created by Storage Class)
    pvc-xxxxx

11. kubectl exec pod/nginx-storageclass-pod -it -- /bin/sh

    From inside the Pod shell

    ls /mnt/azure

    echo "Hello from Azure File Share - Pod" > /mnt/azure/myfile.txt

    ls /mnt/azure

    cat /mnt/azure/myfile.txt

    exit

12. Go to --> Azure Portal --> Storage accounts --> Name starts with fcxxxxxxx

Storage Browser --> Data storage --> File shares --> click on pod-file-share 

Go to Browser --> myfile.txt --> Click on three dots on the right side ... 

Select the Edit option 

Add below text

Hello from Azure Cloud Storage Account 

Click on Save button


13. Create a 2nd Pod try to access the Storage Account

    kubectl apply -f app-2-pod.yaml

    kubectl get pods

    kubectl exec pod/nginx-storageclass-pod-2 -it -- /bin/sh

    From inside the Pod shell:

    ls /mnt/azure

    cat /mnt/azure/myfile.txt

    exit

## 5. NetworkPolicy

## Run the below command to enable the NetworkPolicy Azure plug-in

## Note: Below updates command takes 10 to 15 minutes

Option # 1: (DO THIS OPTION FOR THE NETWORK POLICY LAB) 

     1. Create a Brand new AKS Cluster (MUST)
     2. Networking Tab --> Select Network configuration: Azure CNI Overlay
     3. Networking Tab --> Select Network Policy: Select Azure

Option # 2: (IGNORE FOR THE LAB) 
az aks update --resource-group <AKSResource Group > --name <AKS Cluster Name> --network-policy azure

## Sample

az aks update --resource-group aksworkshopRG --name aksworkshopcluster --network-policy azure

## Network policy Lab

1. cd AKSWorkshop/Lab/Module4/networkpolicy

2. kubectl apply -f deployments.yaml

3. kubectl get pods -o wide

Capture the frontend running Pod name: frontend-app-555749d58-gqxkf

Capture the backend running Pod name: backend-app-69f5976d6b-bbdpk

Capture the frontend IP# : 10.244.1.146

Capture the backend  IP# : 10.244.1.243

## Check Connectivity from Frontend to Backend  

4. kubectl exec -it frontend-app-555749d58-gqxkf -- curl 10.244.1.243 --max-time 1

## Output

<!DOCTYPE html>

<html>

<head>

<title>Welcome to nginx!</title>

# Check Connectivity from Backend to Frontend

5. kubectl exec -it backend-app-69f5976d6b-bbdpk -- curl -sS 10.244.1.146  --max-time 1

## Output

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>

## Apply the Backend Network Policy

6. kubectl apply -f backend-network-policy.yaml

7. kubectl get networkpolicy

kubectl describe networkpolicy backend-network-policy

## 8.Connectivity test

kubectl exec -it frontend-app-555749d58-gqxkf -- curl 10.244.1.243 --max-time 1

kubectl exec -it backend-app-69f5976d6b-bbdpk -- curl -sS 10.244.1.146  --max-time 1

## 9. Check Connectivity from External Sources

kubectl run busybox --image=busybox --rm -it -- /bin/sh

First Usecase

## Test frontend connectivity 

wget --spider --timeout=1 10.244.1.146

Second Usecase

wget --spider --timeout=1 10.244.1.243

## Output for 2 Use Case

Connecting to 10.244.1.146 (10.244.1.146:80)

wget: download timed out

10. kubectl apply -f frontend-network-policy.yaml

11. kubectl get networkpolicy

12. kubectl describe networkpolicy frontend-network-policy

## 13. Check Connectivity from External Sources

kubectl run busybox --image=busybox --rm -it -- /bin/sh

# 1 Usecase

## Test frontend connectivity - Timeout

wget --spider --timeout=1 10.244.1.146

## Output

Connecting to 10.244.1.146 (10.244.1.146:80)

wget: download timed out

# 2 Use case Backend connectivity - Timeout

wget --spider --timeout=1 10.244.1.243

## Output

Connecting to 10.244.1.146 (10.244.1.146:80)

wget: download timed out

## 6. Ingress Controller

## Step 1: Installing NGINX Ingress Controller

1. HELM controller is required to install NGINX Ingress controller. HELM already installed in the Lab VM.
  
2. helm version

# 3. Add the Helm repository:

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update

# 4. Install the NGINX Ingress Controller:

 helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace

 # 5. Check the status of the Ingress Controller:

kubectl get pods -n ingress-nginx

kubectl get svc -n ingress-nginx


## Step 2: Deploy the application

cd AKSWorkshop/Lab/Module4/IngressController

1. Review aks-helloworld-one.yaml

   Line # 29 make sure type: LoadBalancer

2. Review aks-helloworld-two.yaml

   Line # 26 make sure type: LoadBalancer

3. kubectl apply -f aks-helloworld-one.yaml

4. kubectl apply -f aks-helloworld-two.yaml

5. kubectl get pods
   kubectl get services

## Test both the applications

6. Copy the Load balancer IP of the pod aks-helloworld-one

Test the application in a browser: http://<Load balancer IP>

7. Copy the Load balancer IP of the pod aks-helloworld-two

Test the application in a browser: http://<Load balancer IP>

8. Open aks-helloworld-one.yaml

Line # 29 change to type: ClusterIP

9. Open aks-helloworld-two.yaml

Line # 26 change to type: ClusterIP

10. kubectl apply -f hello-world-ingress.yaml

## Output

ingress.networking.k8s.io/hello-world-ingress created

ingress.networking.k8s.io/hello-world-ingress-static created

11. kubectl get ingress

Note: Wait until the ADDRESS show Load Balancer IP

It takes 5 to 10 minutes to allocate a IP.

Action: Capture the Load balancer IP from the ADDRESS column

12. kubectl describe ingress hello-world-ingress

Note: Review the Routing Path

13. Open a browser and test following the service paths

1. http://<Ingress Loadbalancer IP>/hello-world-one

2. http://<Ingress Loadbalancer IP>/hello-world-two

3. http://<Ingress Loadbalancer IP>/AKSWorkshop
