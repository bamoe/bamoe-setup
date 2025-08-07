#!/bin/bash

source ../ocp.properties

# Login to OCP 
source ../scripts/oc-login.sh

# Deployment
echo -e "\nDeploying IBM BAMOE Maven..."
oc apply -f ./deployment-bamoe-maven-repository.yaml

echo -e "\nDeploying IBM BAMOE Canvas..."
oc apply -f ./deployment-bamoe-canvas-extended-services.yaml
oc apply -f ./deployment-bamoe-canvas-cors-proxy.yaml
oc apply -f ./deployment-bamoe-canvas-ui.yaml

echo -e "\nDeploying IBM BAMOE Consoles..."
oc apply -f ./deployment-bamoe-management-console.yaml
oc apply -f ./deployment-bamoe-canvas-cors-proxy.yaml
oc apply -f ./deployment-bamoe-canvas-ui.yaml
