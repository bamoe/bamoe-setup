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

# Select the default project for BAMOE applications
oc project $BAMOE_PROJECT

# Installation
oc new-app ${BAMOE_MGMT_CONSOLE_REPOSITORY_IMAGE} --name=bamoe-management-console
oc create route edge --service=$BAMOE_MGMT_CONSOLE
oc label services/${BAMOE_MGMT_CONSOLE} app.kubernetes.io/part-of=$BAMOE_GROUP
oc label routes/${BAMOE_MGMT_CONSOLE} app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/${BAMOE_MGMT_CONSOLE} app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/${BAMOE_MGMT_CONSOLE} app.openshift.io/runtime=js
