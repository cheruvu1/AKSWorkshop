## Module 1: Docker

1. Download Lab Source code
2. Docker Commands
3. Containerize a Java Sprint Boot application - employee-producer
4. Containerize a Java Sprint Boot application - employee-cert
5. Containerize a .NET application
6. Publish the containers to  ACR (Azure Container Registry) - (Optional)
7. Publish the docker containers to Docker Hub (Optional)

## 1.Download Lab Source code

GitHub URL:

mkdir lab
cd lab
github clone https://

MODULE - 1

## 2.Docker Commands

docker version
docker images  
docker ps  

## 3. Containerize a Java Sprint Boot application - employee-producer

## employee-producer - Microservice

cd lab
cd Module1
cd javaapp
cd employee-producer  
docker build -t employee-producer:1.0 .
OR
docker build –t employee-producer .
docker images  
docker rmi <Image ID>
docker run -d -p 8000:8000 employee-producer:1.0  
docker ps

<http://localhost:8000/employee>
docker stop <container id>
docker rm <container id>  

## For the ARM MAC Users ONLY  

docker build --platform=linux/amd64 -t employee-producer:1.0-amd64 .

docker tag employee-producer:1.0-amd64 azurecloud1/employee-producer:1.0-amd64  

docker push azurecloud1/employee-producer:1.0-amd64

## 4. Containerize a Java Sprint Boot application - employee-cert

cd lab
cd Module1
cd javaapp
cd employee-certifications  
docker build -t employee-cert:1.0 .
OR
docker build –t employee-cert .
docker images  
docker rmi <Image ID>
docker run -d -p 9000:9000 employee-cert:1.0  
docker ps

<http://localhost:9000/empcertifications>  

docker stop <container id>

docker rm <container id>  

## For the ARM MAC Users ONLY  

docker build --platform=linux/amd64 -t employee-cert:1.0-amd64 .

docker tag employee-cert:1.0-amd64 azurecloud1/employee-cert:1.0-amd64  

docker push azurecloud1/employee-cert:1.0-amd64

## 5. Containerize a .NET application

cd lab
cd Module1
cd dotnetapp
cd WebApplication7

docker build -t dotnet-webapp:1.0 .  
OR
docker build -t dotnet-webapp  .  
docker images  
docker rmi <Image ID>
docker run -d -p 80:80 dotnet-webapp:1.0
docker ps
<http://localhost:80> TEST
docker stop <container id>
docker rm <container id>  

## For the ARM MAC Users ONLY  

docker build --platform=linux/amd64 -t dotnet-webapp:1.0-amd64 .

docker tag dotnet-webapp:1.0-amd64 azurecloud1/dotnet-webapp:1.0-amd64  

docker push azurecloud1/dotnet-webapp:1.0-amd64

## 6. Publish the containers to  ACR (Azure Container Registry) - (Optional)

az acr login --name aksworkshopacr.azurecr.us Login to ACR
docker tag employee-producer:1.0-amd64 aksworkshopacr.azurecr.us/employee-producer:1.0  
docker push aksworkshopacr.azurecr.us/employee-producer:1.0  
az acr repository list --name aksworkshopacr
Verify in Azure Portal --> ACR --> Repositories

## 7. Publish the docker containers to Docker Hub (Optional)

docker login [Login to the Docker Hub]
OR
docker login --username <Your Docker ID Name>

## 1

## DotNet Application

docker tag dotnet-webapp:1.0 azurecloud1/dotnet-webapp:1.0 [Tag the image]
docker images [List the images]
docker push azurecloud1/dotnet-webapp:1.0 [Push the images to Docker Hub]

## ARM Mac commands  

docker tag dotnet-webapp:1.0-amd64 azurecloud1/dotnet-webapp:1.0-amd64  

docker push azurecloud1/dotnet-webapp:1.0-amd64

## 2

## Employee Application

docker build --platform=linux/amd64 -t employee-producer:1.0-amd64 .

docker tag employee-producer:1.0-amd64 azurecloud1/employee-producer:1.0-amd64  

docker push azurecloud1/employee-producer:1.0-amd64

## ARM Mac commands  

docker build --platform=linux/amd64 -t employee-producer:1.0-amd64 .

docker tag employee-producer:1.0-amd64 azurecloud1/employee-producer:1.0-amd64  

docker push azurecloud1/employee-producer:1.0-amd64

## 3

## Employee Certifications Application

docker tag employee-cert:1.0-amd64 azurecloud1/employee-cert:1.0-amd64  
docker images
docker push azurecloud1/employee-cert:1.0-amd64

## ARM Mac commands  

docker tag employee-cert:1.0-amd64 azurecloud1/employee-cert:1.0-amd64  

docker push azurecloud1/employee-cert:1.0-amd64
