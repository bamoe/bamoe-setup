#!/bin/bash

source ../ocp.properties

# Login to OCP 
source ./oc-login.sh

# Installation
echo -e "\nInstalling IBM BAMOE Maven into the default project..."
oc new-app ${BAMOE_MAVEN_REPOSITORY_IMAGE} --name ${BAMOE_MAVEN_REPOSITORY}
oc expose service/${BAMOE_MAVEN_REPOSITORY}
oc label services/${BAMOE_MAVEN_REPOSITORY} app.kubernetes.io/part-of=${BAMOE_GROUP}
oc label routes/${BAMOE_MAVEN_REPOSITORY} app.kubernetes.io/part-of=${BAMOE_GROUP}
oc label deployments/${BAMOE_MAVEN_REPOSITORY} app.kubernetes.io/part-of=${BAMOE_GROUP}


