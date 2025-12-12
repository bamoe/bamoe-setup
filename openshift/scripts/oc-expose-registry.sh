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

# Expose the container image registry
echo -e "\nExposing the container image registry..."
oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge
HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
oc extract secret/$(oc get ingresscontroller -n openshift-ingress-operator default -o json | jq '.spec.defaultCertificate.name // "router-certs-default"' -r) -n openshift-ingress --confirm

mv tls.* ~/.bamoe
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/.bamoe/tls.crt
docker login -u kubeadmin -p $(oc whoami -t) $HOST
