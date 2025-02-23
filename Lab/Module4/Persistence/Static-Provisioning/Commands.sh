# CSI File Drivers: https://learn.microsoft.com/en-us/azure/aks/azure-files-csi
# src: https://docs.microsoft.com/en-us/azure/aks/azure-files-volume

## Static Provisioning:

1. Go to --> Azure Portal --> Storage Account -- > Create a new Storage Account
Name: staticstorageaccount
RG: MC_aksbyexample_aksbyexample_usgovarizona
2. Data storage --> File Shares --> + File Share --> static-file-share
3. Security + Networking --> Access Keys --> Copy key1
<Key>
4. kubectl create secret generic azure-secret --from-literal=azurestorageaccountname=staticstorageaccount  --from-literal=azurestorageaccountkey=<Key>
5. kubectl get secrets 
6. kubectl apply -f azure-file-pv.yaml
7. kubectl get pv 
8. kubectl apply -f azure-file-pvc.yaml 
   persistentvolumeclaim/azurefile created
9. kubectl get pvc
NAME           STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
azurefile      Bound    azurefile                                  5Gi        RWX                           15s
my-azurefile   Bound    pvc-e07483b3-219e-478b-90f8-40859e725ed9   5Gi        RWX            my-azurefile   99m
10. kubectl apply -f app-pod.yaml 
11. kubectl get pods
12. kubectl describe pod mypod 
    Mounts:
      /mnt/azure from azure (rw)
13. kubectl exec pod/mypod -it -- /bin/sh
    # From inside the Pod shell:
    # ls /mnt/azure
    # echo "Hello from Azure File Share-Static-Provisioning sharing" > /mnt/azure/StaticShare.txt
    # ls /mnt/azure
    # cat /mnt/azure/StaticShare.txt
14. Azure Protal --> Data storage --> File Shares --> + File Share --> static-file-share
Edit --> Hello from Azure Portal Storage Account --> Save 
15. kubectl exec pod/mypod -it -- /bin/sh
# cat /mnt/azure/StaticShare.txt

