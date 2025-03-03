terraform {
  required_providers {
    keycloak = {
      source = "keycloak/keycloak"
      version = "5.1.1"
    }
  }
}

provider "keycloak" {
  client_id                = "admin-cli"
  url                      = "https://localhost:8443"
  tls_insecure_skip_verify = true
}
