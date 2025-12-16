# IBM Business Automation Manager Open Editions - Red Hat OpenShift Setup
This document includes instructions on how to setup IBM BAMOE on Red Hat OpenShift.

## Overview
The following scripts and Openshift YAML configuation files are made available to setup IBM BAMOE on OpenShift.  Please note that the version of OpenShift that this has been tested on is [OpenShift Local](https://developers.redhat.com/products/openshift-local/overview) and there may be differences when setting up on normal OpenShift.  

The `scripts` folder contains a number of shell scrips that are helpful not only in the installation phase, but also during development and deployment.  There are scripts which allow you to login to the OpenShift CLI or Docker, and scripts which drive the installation process.  Each script expects a property file as it's first input parameter, and there is a sample property file in the following folder in the repository at `./openshift/bamoe-931.properties`, so you can either update this file or create your own.  Each script uses the following syntax:

```shell
cd ./scripts
./<script-file>.sh [optional] ../bamoe-931.properties
```

The following property file is supplied for you, so all you need to do is update some of the OpenShift cluster properties or the version of BAMOE you are installing, which always defaults to the latest version:

```shell
# OpenShift Cluster Properties
OCP_URL=https://api.crc.testing:6443
OCP_CONSOLE_URL=https://console-openshift-console.apps-crc.testing
OCP_USER=kubeadmin
OCP_PASS=**********
OCP_DEFAULT_PROJECT=bamoe-v931

# IBM BAMOE Properties
BAMOE_VERSION=9.3.1-ibm-0006
BAMOE_GROUP=bamoe-v931
BAMOE_PROJECT=bamoe-v931
BAMOE_INFRASTRUCTURE_PROJECT=bamoe-v931-infrastructure
BAMOE_APPS_PROJECT=bamoe-v931-demos

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

# IBM BAMOE MCP Server
BAMOE_MCP_SERVER_REPOSITORY_IMAGE=quay.io/bamoe/mcp-server:${BAMOE_VERSION}
BAMOE_MCP_SERVER=bamoe-mcp-server
BAMOE_MCP_SERVER_OPENAPI_URLS=http://process-service.bamoe-demos:8080/q/openapi
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

## Installation Process
The following process can be followed in order to configure BAMOE on an available OpenShift cluser:

- Install pre-requisists, such as **JDK** 21, a **GIT** client, and a **Maven** client.  See the instructions [here](https://github.com/bamoe/bamoe-setup/blob/main/README.md#requirements-for-local-machine-setup) for local machine pre-reqrequisit installation.  
- Use the [pre-defined scripts](./scripts/README.md) in order to install the various BAMOE product components.
- Use the [pre-defined scripts](./scripts/README.md) in order to install the various BAMOE supported infrastructure components, such as a database.  Please note that not all infrastructure services are required to be installed into the OpenShift cluster.  Please refer to your OpenShift administrator for more information about infrastructure services.

