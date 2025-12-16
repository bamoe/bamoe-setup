# IBM Business Automation Manager Open Editions - Red Hat OpenShift Setup Scripts
This document includes instructions on how to utilize the IBM BAMOE setup scripts on Red Hat OpenShift.

## General Instructions
The collection of scripts, deployment config-maps, operators, services, and route configuration files are located in the OpenShift scripts folder:  `./openshift/scripts`.  Each script can be executed from the command line and takes as an optional parameter a properties file containing pre-defined properties for various BAMOE components to be installed.  You are free to either modify the pre-defined propertie file or create your own and supply it to each script file as the first parameter.  In the following example the basic syntax for any script file takes as an optional parameter the name and location of the properties file.  If no parameter is specified, each script uses the latest version of the BAMOE properties:

```shell
    cd openshift/scripts
    ./oc-login.sh [optional] ../bamoe-931.properties.
```

> [!IMPORTANT]  
> In order to build container images and deploy them to an OpenShift cluster, the local machine or server hosting the CI/CD pipeline must log into docker.  The script entitlted `docker-login.sh` performs this task by first logging into the OpenShift CLI and then using those credentials to log into docker.  This must be done every 24-hours so that docker can save locally built container images to it's registry.  

> [!IMPORTANT]  
> It is also important to note that before you build/deploy any containers to the OpenShift cluster, you must specify which OpenShift project (namespace) you want your deployment to go to.  The BAMOE installation scripts create various projects in the target cluster, some for BAMOE product components, some for BAMOE infrasturcture services, and some for BAMOE business services.

## BAMOE Maven Libraries
In order to install the BAMOE Maven libraries as a container image, use the following script, which automatically selects the Openshift project to install BAMOE Maven into:

```shell
    cd openshift/scripts
    ./bamoe-maven.sh
```

Once the container image is deployed, make note of the public `route` and update your Maven settings.xml file accordingly.  See the instructions [here](https://github.com/bamoe/bamoe-setup/blob/main/maven/README.md) in order to properly configure your Maven settings.xml file.

## BAMOE Canvas
If you organization wishes to use the BAMOE modeling tool known as [BAMOE Canvas](https://www.ibm.com/docs/en/ibamoe/9.3.x?topic=environment-bamoe-canvas), you can install BAMOE Canvas as a container image(s) using the following script, which automatically selects the Openshift project to install BAMOE Canvas into:

```shell
    cd openshift/scripts
    ./bamoe-canvas.sh
```

Once the container image is deployed, make note of the public `route` and update your browser links in order to access BAMOE Canvas' UI.

## BAMOE Management Console
If you organization wishes to use the BAMOE management console, specifically for stateful process instance and user task management, you can install BAMOE Management Console as a container image(s) using the following script, which automatically selects the Openshift project to install BAMOE Management Console into:


```shell
    cd openshift/scripts
    ./bamoe-management-console.sh
```

Once the container image is deployed, make note of the public `route` and update your browser links in order to access BAMOE Management Console's UI.

