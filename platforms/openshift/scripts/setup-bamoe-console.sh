#!/bin/bash

source ../ocp.properties

# Login to OCP 
source ./oc-login.sh

# Installation
echo -e "\nInstalling IBM BAMOE Management Console into the default project..."
oc new-app ${BAMOE_MGMT_CONSOLE_REPOSITORY_IMAGE} --name ${BAMOE_MGMT_CONSOLE}   
oc expose service/${BAMOE_MGMT_CONSOLE}
oc label services/${BAMOE_MGMT_CONSOLE} app.kubernetes.io/part-of=${BAMOE_GROUP}
oc label routes/${BAMOE_MGMT_CONSOLE} app.kubernetes.io/part-of=${BAMOE_GROUP}
oc label deployments/${BAMOE_MGMT_CONSOLE} app.kubernetes.io/part-of=${BAMOE_GROUP}



