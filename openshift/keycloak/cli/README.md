# IBM Business Automation Manager Open Editions - Setup Instructions for Red Hat OpenShift - Red Hat Keycloak

1.  Login to OpenShift cluster...
2.  Select target project: ex: _(oc project bamoe)_
3.  Follow the setup steps below:

```shell
oc process -f keycloak.yaml \
    -p KC_BOOTSTRAP_ADMIN_USERNAME=admin \
    -p KC_BOOTSTRAP_ADMIN_PASSWORD=admin \
    -p NAMESPACE=keycloak \
| oc create -f -
```

```shell
export KEYCLOAK_URL=https://$(oc get route keycloak --template='{{ .spec.host }}') &&
echo "" &&
echo "Keycloak:                 $KEYCLOAK_URL" &&
echo "Keycloak Admin Console:   $KEYCLOAK_URL/admin" &&
echo "Keycloak Account Console: $KEYCLOAK_URL/realms/myrealm/account"
```

