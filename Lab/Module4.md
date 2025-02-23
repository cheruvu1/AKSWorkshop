
## State Persistence


1. Persistent Volumes
2. Persistent Volume Claims
3. How to use PVC in a Pod
4. Storage Classes


## 1. Persistent Volumes  & ## 3. Persistent Volume Claims & ## 4. How to use PVC in a Pod

# CSI File Drivers: https://learn.microsoft.com/en-us/azure/aks/azure-files-csi
# src: https://docs.microsoft.com/en-us/azure/aks/azure-files-volume

## Static Provisioning Demo Steps:

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

4. Security + Networking --> Access Keys --> Copy the key1
<Key>

5. kubectl create secret generic azure-secret --from-literal=azurestorageaccountname=staticstorageaccount  --from-literal=azurestorageaccountkey=<Key>
kubectl create secret generic azure-secret --from-literal=azurestorageaccountname=staticstorageaccount  --from-literal=azurestorageaccountkey=<Replace with Key1>

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
    # From inside the Pod shell:
    # ls /mnt/azure
    # echo "Hello from Azure File Share-Static-Provisioning sharing - Pod" > /mnt/azure/StaticShare.txt
    # ls /mnt/azure
    # cat /mnt/azure/StaticShare.txt

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
# Dynamically create the Azure Storage Account instead of manually creating it.

1. kubectl apply -f azure-file-sc.yaml 
   storageclass.storage.k8s.io/my-azurefile created

2. kubectl get storageclass   
   kubectl describe sc my-azurefile

3. kubectl apply -f azure-file-pvc.yaml
   persistentvolumeclaim/my-azurefile created

4. kubectl get pvc
5. Goto --> 
Azure Portal --> RG: MC_aksworkshopRG_aksworkshopcluster_usgovvirginia 
--> Storage Account --> fc72bf63a9f6e438daf27e4

6. File shares --> pod-file-share --> Browse --> Empty

7. For your Pod to get access to the File shares --> It need permission/access
   Security + networking --> Access Keys

8. Storage Account automatically create the secret for you,
  kubectl get secrets --> azure-storage-account-fc72bf63a9f6e438daf27e4-secret 
  kubectl describe secret azure-storage-account-fc72bf63a9f6e438daf27e4-secret

9. kubectl get secret azure-storage-account-fc72bf63a9f6e438daf27e4-secret -o yaml

10. kubectl apply -f app-pod.yaml
    kubectl get pods 
   kubectl get pv (Note: Persistent Volume Automatically created by Storage Class)
   pvc-ce158f4b-c44b-445a-915a-73be4bc15fdd 

11. kubectl exec pod/nginx-storageclass-pod -it -- /bin/sh
    # From inside the Pod shell:
    # ls /mnt/azure
    # echo "Hello from Azure File Share - Pod" > /mnt/azure/myfile.txt
    # ls /mnt/azure
    # cat /mnt/azure/myfile.txt
    # exit 

12. Go to --> Azure Portal --> File shares --> pod-file-share --> myfile.txt --> Edit --> See the content and Add text --> Hello from Azure Cloud Storage Account --> Pod File Share. 
   # From inside the Pod shell:
     Hello from Azure Cloud Storage Account --> Pod File Share. 

13. Create a 2nd Pod try to access the Storage Account
    kubectl apply -f app-2-pod.yaml 
    kubectl get pods 
    kubectl exec pod/nginx-storageclass-pod-2 -it -- /bin/sh
    # From inside the Pod shell:
    # ls /mnt/azure 
    # cat /mnt/azure/myfile.txt

    exit

