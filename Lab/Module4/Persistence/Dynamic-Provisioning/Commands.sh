Dynamic Provisioning 

# Deploy the Storage Class and PVC to create the Storage Account & File Share
# Dynamically create the Azure Storage Account instead of 
1. kubectl apply -f azure-file-sc.yaml 
   storageclass.storage.k8s.io/my-azurefile created
2. kubectl get storageclass   
3. kubectl get pv (Note: Persistent Volume Automatically created by Storage Class)
   pvc-e07483b3-219e-478b-90f8-40859e725ed9    
3. kubectl apply -f azure-file-pvc.yaml
   persistentvolumeclaim/my-azurefile created
4. kubectl get pvc
5. Goto --> Azure Portal --> RG: MC_aksbyexample_aksbyexample_usgovarizona --> Storage Account --> fe074a27dbb954dd5852145
6. File shares --> pod-file-share --> Empty
7. For your Pod to get access to the File shares --> It need permission/access
   Security + networking --> Access Keys 
8. Storage Account automatically create the secret for you,
  kubectl get secrets --> azure-storage-account-fe074a27dbb954dd5852145-secret 
9. kubectl get secret azure-storage-account-fe074a27dbb954dd5852145-secret -o yaml
10. kubectl apply -f app-pod.yaml
11. kubectl exec pod/nginx -it -- /bin/sh
    # From inside the Pod shell:
    # ls /mnt/azure
    # echo "Hello from Azure File Share" > /mnt/azure/myfile.txt
    # ls /mnt/azure
    # cat /mnt/azure/myfile.txt

12. Go to --> Azure Portal --> File shares --> pod-file-share --> myfile.txt --> Edit --> See the content and Add text --> Hello from Azure Cloud Storage Account --> Pod File Share. 
   # From inside the Pod shell:
     Hello from Azure Cloud Storage Account --> Pod File Share. 

13. Create a 2nd Pod try to access the Storage Account
    kubectl apply -f app-2-pod.yaml 
    kubectl exec pod/nginx-2 -it -- /bin/sh
    # From inside the Pod shell:
    # ls /mnt/azure 
    # cat /mnt/azure/myfile.txt