#!/bin/bash

if [ "$1" == "" ]; then
    echo -e "\nPlease specify a property file name..."
    echo -e "  Example usage: setup-bamoe.sh ../default-ocp.properties\n"
    exit 1
fi

# Load the property file
source $1

# Login to OCP 
source ./oc-login.sh $1

# Create a folder for BAMOE scripts
mkdir $HOME/.bamoe

# Create the BAMOE projects for both BAMOE and supporing infrastructure services
echo -e "\nCreating BAMOE projects...."
oc create project $BAMOE_PROJECT
oc create project $BAMOE_INFRASTRUCTURE_PROJECT
oc create project $BAMOE_APPS_PROJECT
