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
echo -e "\nSetting up BAMOE Canvas Extended Services..."
oc new-app ${BAMOE_CANVAS_EXTENDED_SERVICES_IMAGE} --name=$BAMOE_CANVAS_EXTENDED_SERVICES
oc create route edge --service=$BAMOE_CANVAS_EXTENDED_SERVICES
oc label services/$BAMOE_CANVAS_EXTENDED_SERVICES app.kubernetes.io/part-of=$BAMOE_GROUP
oc label routes/$BAMOE_CANVAS_EXTENDED_SERVICES app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_CANVAS_EXTENDED_SERVICES app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_CANVAS_EXTENDED_SERVICES app.openshift.io/runtime=golang

echo -e "\nSetting up BAMOE Canvas Cors Proxy..."
oc new-app ${BAMOE_CANVAS_CORS_PROXY_IMAGE} --name=$BAMOE_CANVAS_CORS_PROXY
oc create route edge --service=$BAMOE_CANVAS_CORS_PROXY
oc label services/$BAMOE_CANVAS_CORS_PROXY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label routes/$BAMOE_CANVAS_CORS_PROXY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_CANVAS_CORS_PROXY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_CANVAS_CORS_PROXY app.openshift.io/runtime=nodejs

echo -e "\nSetting up BAMOE Canvas UI..."
oc new-app ${BAMOE_CANVAS_UI_REPOSITORY_IMAGE} --name=$BAMOE_CANVAS_UI \
  -e KIE_SANDBOX_EXTENDED_SERVICES_URL=https://$(oc get route $BAMOE_CANVAS_EXTENDED_SERVICES --output jsonpath={.spec.host}) \
  -e KIE_SANDBOX_CORS_PROXY_URL=https://$(oc get route $BAMOE_CANVAS_CORS_PROXY --output jsonpath={.spec.host})
oc create route edge --service=$BAMOE_CANVAS_UI
oc label services/$BAMOE_CANVAS_UI app.kubernetes.io/part-of=$BAMOE_GROUP
oc label routes/$BAMOE_CANVAS_UI app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_CANVAS_UI app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_CANVAS_UI app.openshift.io/runtime=js