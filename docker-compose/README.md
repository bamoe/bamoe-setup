# IBM Business Automation Manager Open Editions - Setup Instructions - Docker Compose
If you are currently running docker, podman, or Rancher Desktop, you can utilize the docker compose configuration scripts in this section of the repository.  You can use `Docker Compose` to run the BAMOE images locally and the easiest way is to use `Rancher Desktop`.  Click [here](https://docs.rancherdesktop.io/getting-started/installation/) in order to get instructions on how to install Rancher Desktop in Docker mode.  

## Maven Repository
For more information on how to properly setup Maven for local development, visit [Setting Up Maven](../maven/README.md).

## Container Images
All published BAMOE images can be pulled directly from Quay.io.  Here are the steps to follow:

1.  To install the basic BAMOE services, use the supplied `docker-compose.yml` in the `docker-compose` folder:

    ```bash
    docker compose up [optional]<service-name>
    ```

    where `<service-name>` equals the name of the service in compose file (optional, leaving this off will install all services in the `docker-compose.yml` file.)

2.  To install the extended infrastructure services, mostly used by PAMOE, use the supplied `docker-compose-infrastructure.yml` in the `docker-compose` folder:

    ```bash
    docker compose -f docker-compose-infrastructure.yml up [optional]<service-name>
    ```

    where `<service-name>` equals the name of the service in compose file (optional, leaving this off will install all services in the `docker-compose-infrastructure.yml` file.)

3.  The images will start containers on the following ports:

    | Service                   | Port @ localhost              |
    | ------------------------- | ----------------------------- |
    | BAMOE Maven               | [9011](http://localhost:9020) |
    | BAMOE Canvas              | [9090](http://localhost:9090) |







