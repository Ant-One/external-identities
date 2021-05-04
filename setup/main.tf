# Royaume keycloak contenant toute la configuration
resource "keycloak_realm" "realm" {
  realm   = var.realm_name
  enabled = true
}

# Ensemble d'utilisateurs appartenant au royaume
resource "keycloak_user" "user_with_initial_password" {
  for_each = { for user in var.users : user.username => user }

  realm_id = keycloak_realm.realm.id
  enabled  = true

  username   = each.value.username
  first_name = each.value.first_name
  last_name  = each.value.last_name
  email      = each.value.email

  # On configure ici le mot de passe d'une manière très simple pour la démonstration
  initial_password {
    value     = "password"
    temporary = false
  }
}
