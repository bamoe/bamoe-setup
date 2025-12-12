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
echo -e "\nInstalling PostgreSQL databaase..."
oc apply -f ../config-maps/config-map-postgres-931.yaml
oc apply -f ../deployments/deployment-postgres.yaml
oc apply -f ../services/service-postgres.yaml
