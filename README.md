# External Identities

Sandbox project configuring a local Keycloak used to demonstrate the capabilities of Azure's external identities.


## Install Keycloak

```bash
export KEYCLOAK_USER=admin
export KEYCLOAK_PASSWORD=admin

docker run -d --name keycloak -p 8080:8080 -e KEYCLOAK_USER=$KEYCLOAK_USER -e KEYCLOAK_PASSWORD=$KEYCLOAK_PASSWORD quay.io/keycloak/keycloak:12.0.4
```

A local Keycloak will be available at the following address: http://localhost:8080


## Setup

```bash
# Go into the proper directory
cd setup

# Initialize Terraform configuration
terraform init

# Establish a plan of what resources will be created
terraform plan

# Create the given resources
terraform apply
```