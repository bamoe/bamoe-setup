#!/bin/bash

if [ "$1" == "" ]; then
  props=../bamoe-931.properties
else
  props=$1
fi

# Load the property file
source $props

# Login to OCP 
source ./oc-login.sh $props

# Select the default project for BAMOE infrastrudture applications
oc project $BAMOE_INFRASTRUCTURE_PROJECT

# Installation 
echo -e "\nInstalling PostgreSQL admin console..."
oc apply -f ../deployments/deployment-pgweb.yaml
oc apply -f ../services/service-pgweb.yaml
oc apply -f ../routes/route-pgweb.yaml

