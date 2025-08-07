#!/bin/bash

source ../ocp.properties

# Login to OpenShift cluster
echo -e "\nLogging into the cluster and setting the default project..."
oc login --username=${OCP_USER} --password=${OCP_PASS} ${OCP_URL}
oc project ${OCP_DEFAULT_PROJECT}
