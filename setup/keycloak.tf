# Keycloak realm holding the configuration
resource "keycloak_realm" "realm" {
  realm   = var.realm_name
  enabled = true
}

# Set of users belonging to the realm
resource "keycloak_user" "user_with_initial_password" {
  for_each = { for user in var.users : user.username => user }

  realm_id = keycloak_realm.realm.id
  enabled  = true

  username   = each.value.username
  first_name = each.value.first_name
  last_name  = each.value.last_name
  email      = each.value.email

  # Password setup is done in the most simple way for the purpose of this demo
  initial_password {
    value     = "password"
    temporary = false
  }
}
