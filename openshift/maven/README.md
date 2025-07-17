# IBM Business Automation Manager Open Editions - Setup Instructions for Red Hat OpenShift - BAMOE Maven Repository

1.  Login to OpenShift cluster...
2.  Select target project: ex: _(oc project bamoe)_
3.  Execute the following commands in the target project:

    ```shell
    export BAMOE_MAVEN_REPOSITORY_IMAGE=quay.io/bamoe/maven-repository:9.2.1-ibm-0005

    oc new-app ${BAMOE_MAVEN_REPOSITORY_IMAGE} --name bamoe-maven-repository
    oc create route edge --service=bamoe-maven-repository
    ```