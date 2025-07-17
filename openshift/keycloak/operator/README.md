# IBM Business Automation Manager Open Editions - Setup Instructions for Red Hat OpenShift - Red Hat Keycloak

1.  Login to OpenShift cluster...
2.  Select target project: ex: _(oc project bamoe)_
3.  Install operator: rhbk-operator.v26.2.5-opr.1 provided by Red Hat
4.  Configure via operator:

## Provision Database
A database should be available and accessible from the cluster namespace where Red Hat build of Keycloak is installed. The Red Hat build of Keycloak Operator does not manage the database and you need to provision it yourself. Consider verifying your cloud provider offering or using a database operator.  For development purposes, you can use an ephemeral PostgreSQL pod installation. To provision it, follow the approach below: 

```shell
oc apply -f bamoe-keycloak-postgresql.yaml
```

## Hostname

## TLS Certificate and Key
For development purposes, you can enter this command to obtain a self-signed certificate: 

```shell
openssl req -subj '/CN=bamoe.keycloak.org/O=BAMOE Keycloak./C=US' -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem
```

You should install it in the cluster namespace as a Secret by entering this command: 

```shell
oc create secret tls bamoe-tls-secret --cert certificate.pem --key key.pem
```

## KeyCloak Deployment
To deploy Red Hat build of Keycloak, you create a Custom Resource (CR) based on the Keycloak Custom Resource Definition (CRD).  Consider storing the Database credentials in a separate Secret. Enter the following:

```shell
oc create secret generic bamoe-keycloak-db-secret --from-literal=username=bamoe-user --from-literal=password=bamoe-pass
```

You can customize several fields using the Keycloak CRD. For a basic deployment, you can stick to the following approach: 

```shell
oc apply -f bamoe-keycloak.yaml
oc get keycloaks/bamoe-keycloak -o go-template='{{range .status.conditions}}CONDITION: {{.type}}{{"\n"}}  STATUS: {{.status}}{{"\n"}}  MESSAGE: {{.message}}{{"\n"}}{{end}}'
```
