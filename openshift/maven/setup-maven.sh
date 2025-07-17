# This script sets up the BAMOE Maven container image
echo "Setting up BAMOE Maven..."

# Repository Images
export BAMOE_GROUP=bamoe
export BAMOE_MAVEN_REPOSITORY_IMAGE=quay.io/bamoe/maven-repository:9.2.1-ibm-0005
export BAMOE_MAVEN_REPOSITORY=bamoe-maven-repository

# Installation
oc new-app ${BAMOE_MAVEN_REPOSITORY_IMAGE} --name $BAMOE_MAVEN_REPOSITORY
oc create route edge --service=$BAMOE_MAVEN_REPOSITORY
oc label services/$BAMOE_MAVEN_REPOSITORY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label routes/$BAMOE_MAVEN_REPOSITORY app.kubernetes.io/part-of=$BAMOE_GROUP
oc label deployments/$BAMOE_MAVEN_REPOSITORY app.kubernetes.io/part-of=$BAMOE_GROUP


