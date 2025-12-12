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

# Create a folder for BAMOE scripts
mkdir $HOME/.bamoe

# Create the BAMOE projects for both BAMOE and supporing infrastructure services
echo -e "\nCreating BAMOE projects...."
oc create project $BAMOE_PROJECT
oc create project $BAMOE_INFRASTRUCTURE_PROJECT
oc create project $BAMOE_APPS_PROJECT
