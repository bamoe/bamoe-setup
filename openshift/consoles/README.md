# IBM Business Automation Manager Open Editions - Setup Instructions for Red Hat OpenShift - BAMOE Consoles

1.  Login to OpenShift cluster...
2.  Select target project: ex: _(oc project bamoe)_
3.  Execute the following commands in the target project:

```shell
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
oc label services/${BAMOE_CONSOLES_APP} app.kubernetes.io/part-of=$BAMOE_CONSOLES
```