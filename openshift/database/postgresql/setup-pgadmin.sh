# This script sets up PostgreSQL pgAdmin
echo "Setting up PostgreSQL pgAdmin..."

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
