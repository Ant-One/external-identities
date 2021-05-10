terraform {
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
    }
  }
}

provider "keycloak" {
  client_id                = "admin-cli"
  url                      = "https://localhost:8443"
  tls_insecure_skip_verify = true
}
