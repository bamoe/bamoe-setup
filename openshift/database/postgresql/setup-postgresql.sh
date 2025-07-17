# This script sets up PostgreSQL 17
echo "Setting up PostgreSQL 17..."

echo -e "\nInstalling PostgreSQL 17 image..."
cd builders/postgresql-17
oc new-build --binary --strategy=docker --name=bamoe-postgresql
oc start-build bamoe-postgresql --from-dir=. --follow
cd ../..

echo -e "\nDeploying PostgreSQL 17..."
oc get istag bamoe-postgresql:latest
oc apply -f bamoe-postgresql-deployment.yaml

echo -e "\nChecking installation..."
oc get pods
oc logs deployment/postgres

