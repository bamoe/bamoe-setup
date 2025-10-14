#!/bin/bash

if [ "$1" == "" ]; then
    echo -e "\nPlease specify a property file name..."
    echo -e "  Example usage: create-bamoe-management-console.sh ../../default-ocp.properties\n"
    exit 1
fi

# Load the property file
source $1

# Login to OCP 
source ../oc-login.sh $1

# Select the default project for BAMOE applications
oc project $BAMOE_PROJECT

# Installation
oc new-app ${BAMOE_MGMT_CONSOLE_REPOSITORY_IMAGE} --name=bamoe-management-console
oc create route edge --service=$BAMOE_MGMT_CONSOLE
oc label services/${BAMOE_MGMT_CONSOLE} app.kubernetes.io/part-of=$BAMOE_GROUP
oc label routes/${BAMOE_MGMT_CONSOLE} app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/${BAMOE_MGMT_CONSOLE} app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/${BAMOE_MGMT_CONSOLE} app.openshift.io/runtime=js
