# This script sets up BAMOE Consoles
echo "Setting up BAMOE Consoles..."

# Repository Images
export BAMOE_VERSION=9.2.1-ibm-0005
export BAMOE_CONSOLES_HELM=oci://quay.io/bamoe/consoles-helm-chart
export BAMOE_CONSOLES=bamoe-consoles
export CLUSTER_DOMAIN=apps.ocp.ibm.edu

# Install consoles
helm pull ${BAMOE_CONSOLES_HELM} --version=$BAMOE_VERSION --untar
helm install $BAMOE_CONSOLES ./consoles-helm-chart --values ./consoles-helm-chart/values-openshift.yaml --set global.openshiftRouteDomain=${CLUSTER_DOMAIN}

