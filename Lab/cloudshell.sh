
docker login --username azurecloud1

kubectl describe pod dotnet-pod
kubectl get pods


## DOTNET
docker build --platform=linux/amd64 -t dotnet-webapp:1.0-amd64 .

docker tag dotnet-webapp:1.0-amd64 azurecloud1/dotnet-webapp:1.0-amd64  

docker push azurecloud1/dotnet-webapp:1.0-amd64





http://52.243.251.55:8000/employee


az acr login --name aksworkshopacr.azurecr.us


docker build -t employee-cert:1.0 .
docker images
docker tag employee-producer:1.0-amd64 aksworkshopacr.azurecr.us/employee-producer:1.0
docker push aksworkshopacr.azurecr.us/employee-producer:1.0
az acr repository list --name aksbyexampleacr 
Verify in Azure Portal --> ACR --> Repositories

docker build --platform=linux/arm64 -t employee-cert:1.0-arm64 .

docker tag employee-cert:7.0-amd64 aksbyexampleacr.azurecr.us/employee-cert:7.0-amd64 
docker push aksbyexampleacr.azurecr.us/employee-cert:7.0-amd64 

docker tag dotnet-webap:1.0 cheruvu007/dotnet-webapp:1.0 

docker push cheruvu007/dotnet-webapp:1.0

docker tag dotnet-webapp:1.0 azurecloud1/dotnet-webapp:1.0 

docker push azurecloud1/dotnet-webapp:1.0

azurecloud1



$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh


