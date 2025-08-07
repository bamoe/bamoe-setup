#!/bin/bash

source ../ocp.properties

# Login to OCP 
source ./oc-login.sh

# Installation
echo -e "\nSetting up IBM BAMOE Canvas Extended Services..."
oc new-app ${BAMOE_CANVAS_EXTENDED_SERVICES_IMAGE} --name=$BAMOE_CANVAS_EXTENDED_SERVICES
oc create route edge --service=$BAMOE_CANVAS_EXTENDED_SERVICES
oc label services/$BAMOE_CANVAS_EXTENDED_SERVICES app.kubernetes.io/part-of=${BAMOE_GROUP}
oc label routes/$BAMOE_CANVAS_EXTENDED_SERVICES app.kubernetes.io/part-of=${BAMOE_GROUP}
oc label deployments/$BAMOE_CANVAS_EXTENDED_SERVICES app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_CANVAS_EXTENDED_SERVICES app.openshift.io/runtime=golang

echo -e "\nSetting up IBM BAMOE Canvas Cors Proxy..."
oc new-app ${BAMOE_CANVAS_CORS_PROXY_IMAGE} --name=$BAMOE_CANVAS_CORS_PROXY
oc create route edge --service=$BAMOE_CANVAS_CORS_PROXY
oc label services/$BAMOE_CANVAS_CORS_PROXY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label routes/$BAMOE_CANVAS_CORS_PROXY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_CANVAS_CORS_PROXY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_CANVAS_CORS_PROXY app.openshift.io/runtime=nodejs

echo -e "\nSetting up IBM BAMOE Canvas UI..."
oc new-app ${BAMOE_CANVAS_UI_REPOSITORY_IMAGE} --name=$BAMOE_CANVAS_UI \
  -e KIE_SANDBOX_EXTENDED_SERVICES_URL=https://$(oc get route $BAMOE_CANVAS_EXTENDED_SERVICES --output jsonpath={.spec.host}) \
  -e KIE_SANDBOX_CORS_PROXY_URL=https://$(oc get route $BAMOE_CANVAS_CORS_PROXY --output jsonpath={.spec.host})
oc create route edge --service=$BAMOE_CANVAS_UI
oc label services/$BAMOE_CANVAS_UI app.kubernetes.io/part-of=$BAMOE_GROUP
oc label routes/$BAMOE_CANVAS_UI app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_CANVAS_UI app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_CANVAS_UI app.openshift.io/runtime=js

