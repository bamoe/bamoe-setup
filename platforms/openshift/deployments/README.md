# IBM Business Automation Manager Open Editions - OpenShift Deployments
This folder contains the IBM BAMOE OpenShift deployment files, used to install IBM BAMOE components into a non-production OpenShift cluster.

## How To Use
To install IBM BAMOE components into OpenShift using deployments, you can either run each deployment seperately using the following syntax:

```shell
oc apply -f <deployment.yaml>
```

or you can use the pre-build script, which creates deployments in a specific order as a batch process:

```shell
./deploy-bamoe.sh
```
