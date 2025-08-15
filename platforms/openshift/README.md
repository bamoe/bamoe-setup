# IBM Business Automation Manager Open Editions - Red Hat OpenShift Setup
This document includes instructions on how to setup IBM BAMOE on Red Hat OpenShift.

## Overview
The following scripts and Openshift YAML configuation files are made available to setup IBM BAMOE on OpenShift.  Please note that the version of OpenShift that this has been tested on is [OpenShift Local](https://developers.redhat.com/products/openshift-local/overview) and there may be differences when setting up on normal OpenShift.  

The `scripts` folder contains a number of shell scrips that are helpful not only in the installation phase, but also during development and deployment.  There are scripts which allow you to login to the OpenShift CLI or Docker, and scripts which drive the installation process.  Each script expects a property file as it's first input parameter, and there is a sample property file in the following folder in the repository:  `platforms/openshift/ocp.properties`, so you can either update this file or create your own.  Each script uses the following syntax:

```shell
cd ./platforms/openshift/scripts
./<script-file>.sh ../default-ocp.properties
```

The following property file is supplied for you, so all you need to do is update some of the OpenShift cluster properties or the version of BAMOE you are installing, which always defaults to the latest version:

```shell
# OpenShift Cluster Properties
OCP_URL=https://api.crc.testing:6443
OCP_CONSOLE_URL=https://console-openshift-console.apps-crc.testing
OCP_USER=kubeadmin
OCP_PASS=<password>
OCP_DEFAULT_PROJECT=bamoe-v921

# IBM BAMOE Properties
BAMOE_VERSION=9.2.1-ibm-0005
BAMOE_GROUP=bamoe-v921
BAMOE_PROJECT=bamoe-v921
BAMOE_INFRASTRUCTURE_PROJECT=bamoe-v921-infrastructure
BAMOE_APPS_PROJECT=bamoe-apps

# IBM BAMOE Maven
BAMOE_MAVEN_REPOSITORY_IMAGE=quay.io/bamoe/maven-repository:${BAMOE_VERSION}
BAMOE_MAVEN_REPOSITORY=bamoe-maven-repository

# IBM BAMOE Canvas
BAMOE_CANVAS_EXTENDED_SERVICES_IMAGE=quay.io/bamoe/extended-services:${BAMOE_VERSION}
BAMOE_CANVAS_CORS_PROXY_IMAGE=quay.io/bamoe/cors-proxy:${BAMOE_VERSION}
BAMOE_CANVAS_UI_REPOSITORY_IMAGE=quay.io/bamoe/canvas:${BAMOE_VERSION}
BAMOE_CANVAS_EXTENDED_SERVICES=bamoe-canvas-extended-services
BAMOE_CANVAS_CORS_PROXY=bamoe-canvas-cors-proxy
BAMOE_CANVAS_UI=bamoe-canvas-ui
BAMOE_CANVAS_REQUIRE_CUSTOM_COMMIT_MESSAGE=true

# IBM BAMOE Management Console
BAMOE_MGMT_CONSOLE_REPOSITORY_IMAGE=quay.io/bamoe/management-console:${BAMOE_VERSION}
BAMOE_MGMT_CONSOLE=bamoe-management-console
```

The easiest route to a clean installation is to use the scripts, which may install multiple OpenShift objects for each application, such as a config-map, deployment, service, or routes.  You can bypass the scripts and simply use the OpenShift object YAML files as is, in case you need to update a particular component of the installation, using the following syntax example:

```shell
oc apply -f ./deployments/deployment-bamoe-maven-repository.yaml
```

## OpenShift Local Configuration
The followoing configuration was used in order to test the OpenShift Local setup for IBM BAMOE:

- Memory: 25g
- CPUs: 6
- Disk: 75g

If you need to configuration your local cluster, you can use the following commands to update it's configuration:

```shell
crc stop
crc config set memory 25000
crc config set cpus 6
crc config set disk-size 75
crc start
```

## Installing Common IBM BAMOE Applications
There is a short list of IBM BAMOE applications that you should deploy to the OpenShift cluster, in order to make those applications available to the developer/business user.  These applications, while they rely on infrastructure services, do not require the infrastructure services to be deployed in any particular order.  So we can deploy all IBM BAMOE appliations first, and then add the various infrastucture services that our applications will require.

![Under Construction](/doc/images/under-construction.png)
