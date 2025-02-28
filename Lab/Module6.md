
## Advanced AKS

1. Azure Fleet Manager
2. HELM Package Manager

# 1. Azure Fleet Manager

1. Login to Azure Portal

2. Create total 2 new AKS clusters.  Select default options while creating AKS Clusters.

   1) Fleet-cluster-1

   2) Fleet-cluster-2

Note: Make a note of the Kubernetes Version -> Basics tab -> Kubernetes Version: 1.30.9

3. On the Azure portal home page, select Create a resource.
   In the search box, enter Kubernetes Fleet Manager and
   select Create > Kubernetes Fleet Manager from the search results.

4. Create a new Azure Kubernetes Fleet Manager instance and select the hub cluster mode without hub cluster.

5. On the Basics tab, configure the following options:

 Under Project details:

 Subscription: Select the Azure subscription that you want to use.

 Resource group: Select an existing resource group or select Create new to create a new resource group.

 Under Fleet details:

 Name: Enter a unique name for the Fleet resource.

 Region: Select the region where you want to create the Fleet resource.

 Hub cluster mode:  Select Without hub cluster if you want to use Fleet only for update orchestration.

6. Select Next: Member clusters.

7. On the Member clusters tab, select Add to add an existing AKS cluster as a member cluster to the Fleet resource. You can add multiple member clusters to the Fleet resource.

8. Add the following 2 cluster you created in Step # 2.  Select the check box next to below 2 cluster

      1) Fleet-cluster-1

      2) Fleet-cluster-2

Click on Add button

9. Update the group: stage for both the clusters

10. Review + create

11. create

12. Go to resource

## Define an update strategy

13. Under Settings -> Multi-cluster update -> Click on Strategies (the 3rd tab on the right side)

14. Create a strategy

15. Provide a Strategy Name: aks-strategy

16. Select the button: Create stage  

17. Provide a Stage Name: version-stage

18. Select the Check Box: Update group + member cluster

19. Total 2 times

Select the button: Create

Select the button: Create

## Create a Run

24. Select the first tab: Runs -> + Create a run -> Manual run

25. Run name: aks-upgrade-run -> Update sequence: Stages

26. Upgrade scope : Kubernetes version (control plane and node pools)  

27. Select the button: Copy from existing strategy

28. Select the radio button: aks-strategy / version-stage -> Select

29. Kubernetes version: 1.31.1 (Select any higher version than your current version)

30. Select the button: Create

31. Under the Runs tab: Click the Check box: aks-upgrade-run

32. Check the box next to your RUN

33. Select the button:  > Start

## You can view the running status

34. Select the blue link: version-stage

## 2. HELM Package Manager

1. cd AKSWorkshop/Lab/Module6/helm

# Please make sure to lint your chart before you try to deploy it, it will help you to identify any issue upfront

2. helm lint aksapplication

# Execute below command to install the first chart on Kubernetes cluster

3. helm install enterpriserelease aksapplication

# Check the Status of the deployment / See the history

4. helm list
