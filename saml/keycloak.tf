locals {
  azure_tenant_login_url = "https://login.microsoftonline.com/${var.tenant_id}/saml2/"
  saml_client_name       = "azure-idp-saml"
}

# Client used for SAML authentication with Azure
resource "keycloak_saml_client" "saml_client" {
  realm_id    = data.keycloak_realm.realm.id                        # Realm where the client will be provisioned.
  client_id   = "https://login.microsoftonline.com/${var.tenant_id}/"                    # Client ID. It must be this value or it the authentication won't work.
  name        = local.saml_client_name                              # Name of the client
  description = "SAML client to federate access on an Azure tenant" # Client description

  base_url            = "/auth/realms/${data.keycloak_realm.realm.id}/protocol/saml/clients/${local.saml_client_name}" # URL used whenever Keycloak needs to link to this client
  master_saml_processing_url = [local.azure_tenant_login_url]
  valid_redirect_uris = [local.azure_tenant_login_url]                                                                 # List of URIs that the SAML client is allowed to redirect to

  name_id_format              = "email"                      # Format of the NameID property inside SAML documents
  #assertion_consumer_post_url = local.azure_tenant_login_url # SAML POST Binding URL for the client's assertion consumer service (login responses).

  sign_documents            = true       # Keycloak will sign SAML documents
  sign_assertions           = true       # Keycloak will sign SAML assertions
  signature_algorithm       = "RSA_SHA256" # Algorithm used by Keycloak to sign SAML documents
  client_signature_required = false      # Keycloak will not expect documents or assignments coming from the client to be signed (Does not work with Azure). 

  include_authn_statement = true # Keycloak will include an AuthnStatement in the SAML response.
  front_channel_logout    = true # Setting this will require a browser redirection in order to perform a logout
}

# SAML user mapper to include email address in SAML documents
# This must be commented out if you use the script protocol mapper right below
resource "keycloak_saml_user_attribute_protocol_mapper" "saml_email_mapper" {
  realm_id  = data.keycloak_realm.realm.id
  client_id = keycloak_saml_client.saml_client.id
  name      = "email"

  user_attribute             = "email"
  saml_attribute_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
  saml_attribute_name_format = "Basic"
}



# This resource is only needed if your user domain is different that the one that is configured in the Direct Federation
# Since it is not possible toregister a domain that is already claim by an Azure Active Directory, we might need to used a custom domain
# Hence the need for a protocol mapper that will translate to email address domain to match the one configured on Azure.
#
# resource "keycloak_saml_script_protocol_mapper" "saml_script_mapper" {
#   realm_id  = data.keycloak_realm.realm.id
#   client_id = keycloak_saml_client.saml_client.id
#   name      = "email"

#   saml_attribute_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
#   saml_attribute_name_format = "Basic"

#   script = <<-EOT
#   var new_domain = '${var.domain_name}';
#   var username = user.email.substring(0, user.email.lastIndexOf("@"));
#   var new_email = username + '@' + new_domain;

#   exports = new_email;
#   EOT
# }
