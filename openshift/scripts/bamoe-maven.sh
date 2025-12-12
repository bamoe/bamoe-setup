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
oc new-app ${BAMOE_MAVEN_REPOSITORY_IMAGE} --name $BAMOE_MAVEN_REPOSITORY
oc create route edge --service=$BAMOE_MAVEN_REPOSITORY
oc label services/$BAMOE_MAVEN_REPOSITORY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label routes/$BAMOE_MAVEN_REPOSITORY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_MAVEN_REPOSITORY app.kubernetes.io/part-of=$BAMOE_GROUP
