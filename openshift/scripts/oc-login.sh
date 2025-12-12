#!/bin/bash

if [ "$1" == "" ]; then
  props=../bamoe-931.properties
else
  props=$1
fi

# Load the property file
source $props

# Login to OpenShift cluster
echo -e "\nLogging into the cluster and setting the default project..."
oc login --username=${OCP_USER} --password=${OCP_PASS} ${OCP_URL}
oc project ${OCP_DEFAULT_PROJECT}
