variable "tenant_id" {
  type        = string
  description = "ID of the Azure tenant that the SAML client will redirect to"
}

variable "realm_name" {
  type        = string
  description = "Realm name of Keycloak"
  default     = "external-identities"
}

# variable "domain_name" {
#   type        = string
#   description = "Domain name configured on External Identities."
# }
