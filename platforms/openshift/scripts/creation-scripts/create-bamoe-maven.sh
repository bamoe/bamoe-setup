#!/bin/bash

if [ "$1" == "" ]; then
    echo -e "\nPlease specify a property file name..."
    echo -e "  Example usage: create-bamoe-maven.sh ../../default-ocp.properties\n"
    exit 1
fi

# Load the property file
source $1

# Login to OCP 
source ../oc-login.sh $1

# Select the default project for BAMOE applications
oc project $BAMOE_PROJECT

# Installation
oc new-app ${BAMOE_MAVEN_REPOSITORY_IMAGE} --name $BAMOE_MAVEN_REPOSITORY
oc create route edge --service=$BAMOE_MAVEN_REPOSITORY
oc label services/$BAMOE_MAVEN_REPOSITORY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label routes/$BAMOE_MAVEN_REPOSITORY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_MAVEN_REPOSITORY app.kubernetes.io/part-of=$BAMOE_GROUP
