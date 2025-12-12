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

# Login to Docker using OCP token
echo -e "\nLogging into Docker using OCP token..."
OCP_HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
docker login -u $(oc whoami) -p $(oc whoami -t) $OCP_HOST
