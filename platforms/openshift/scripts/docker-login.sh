#!/bin/bash

source ../ocp.properties

# Login to OCP 
source ./oc-login.sh

# Login to Docker using OCP token
echo -e "\nLogging into Docker using OCP token..."
OCP_HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
docker login -u $(oc whoami) -p $(oc whoami -t) $OCP_HOST
