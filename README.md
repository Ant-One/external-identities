# External Identities

Sandbox project configuring a local Keycloak used to demonstrate the capabilities of Azure's external identities.


## Install Keycloak

```bash
export KEYCLOAK_USER=admin
export KEYCLOAK_PASSWORD=admin

docker run -d --name keycloak -p 8443:8443 -e KEYCLOAK_USER=$KEYCLOAK_USER -e KEYCLOAK_PASSWORD=$KEYCLOAK_PASSWORD quay.io/keycloak/keycloak:12.0.4
```

A local Keycloak will be available at the following address: https://localhost:8443


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


## SAML

```bash
# Set your Azure tenant ID as an environment variable
export TENANT_ID=...

# Go into the proper directory
cd saml

# Initialize Terraform configuration
terraform init

# Establish a plan of what resources will be created
terraform plan -var tenant_id=$TENANT_ID

# Create the given resources
terraform apply -var tenant_id=$TENANT_ID
```