#!/bin/bash

if [ "$1" == "" ]; then
    echo -e "\nPlease specify a property file name..."
    echo -e "  Example usage: create-bamoe-mcp-serveren.sh ../../default-ocp.properties\n"
    exit 1
fi

# Load the property file
source $1

# Login to OCP 
source ../oc-login.sh $1

# Select the default project for BAMOE applications
oc project $BAMOE_PROJECT

# Installation
oc new-app ${BAMOE_MCP_SERVER_REPOSITORY_IMAGE} --name $BAMOE_MCP_SERVER \
  -e MCP_SERVER_OPENAPI_URLS=$BAMOE_MCP_SERVER_OPENAPI_URLS
oc create route edge --service=$BAMOE_MCP_SERVER
#oc label services/$BAMOE_MCP_SERVER app.kubernetes.io/part-of=$BAMOE_GROUP
#oc label routes/$BAMOE_MCP_SERVER app.kubernetes.io/part-of=$BAMOE_GROUP
#oc label deployments/$BAMOE_MCP_SERVER app.kubernetes.io/part-of=$BAMOE_GROUP
