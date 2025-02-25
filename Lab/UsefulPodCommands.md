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

