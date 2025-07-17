# BAMOE PostgreSQL Installation Instructions

## PostgreSQL 17

1.  Login to OpenShift cluster...
2.  Select target project: ex: _(oc project bamoe)_
3.  Execute the following commands in the target project:

    ```shell
    echo -e "\nInstalling PostgreSQL 17 image..."
    cd builders/postgresql-17
    oc new-build --binary --strategy=docker --name=bamoe-postgresql
    oc start-build bamoe-postgresql --from-dir=. --follow
    cd ../..

    echo -e "\nDeploying PostgreSQL 17..."
    oc get istag bamoe-postgresql:latest
    oc apply -f bamoe-postgresql-deployment.yaml
    ```

4.  Verify if pod is running

    ```shell
    echo -e "\nChecking installation..."
    oc get pods
    oc logs deployment/postgres
    ```

## PostgreSQL pgAdmin

1.  Login to OpenShift cluster...
2.  Select target project: ex: _(oc project bamoe)_
3.  Execute the following commands in the target project:

    ```shell
    echo -e "\nInstalling PostgreSQL pgAdmin image..."
    cd builders/pgadmin
    oc new-build --binary --strategy=docker --name=bamoe-pgadmin
    oc start-build bamoe-pgadmin --from-dir=. --follow

    echo -e "\nSetting service account policy..."
    oc adm policy add-scc-to-user anyuid -z default -n bamoe

    echo -e "\nDeploying pgAdmin..."
    oc new-app bamoe-pgadmin \
      -e PGADMIN_DEFAULT_EMAIL=user@bamoe.ibm.com \
      -e PGADMIN_DEFAULT_PASSWORD=pass \
      --name=bamoe-pgadmin

    echo -e "\nChecking installation..."
    oc get pods

    echo -e "\nCreating external routes....."
    oc expose svc/bamoe-pgadmin
    oc get route bamoe-pgadmin -o jsonpath='{.spec.host}'
    ```

## pgAdmin Console
    - URL: http://bamoe-pgadmin-bamoe.apps.ocp.ibm.edu/browser/
    - Username: user@bamoe.ibm.com
    - Password: pass