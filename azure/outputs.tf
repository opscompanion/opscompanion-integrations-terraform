output "application_id" {
  description = "Client ID (Application ID) of the Azure AD application"
  value       = azuread_application_registration.opscompanion_app.client_id
}

output "service_principal_id" {
  description = "Object ID of the service principal"
  value       = azuread_service_principal.opscompanion_sp.object_id
}

output "service_principal_application_id" {
  description = "Application ID associated with the service principal"
  value       = azuread_service_principal.opscompanion_sp.client_id
}

output "tenant_id" {
  description = "Azure AD tenant ID"
  value       = data.azuread_client_config.current.tenant_id
}

output "subscription_id" {
  description = "Azure subscription ID where resources were created"
  value       = data.azurerm_subscription.current.subscription_id
}

output "custom_role_id" {
  description = "ID of the custom role definition"
  value       = azurerm_role_definition.opscompanion_readonly.role_definition_id
}

output "custom_role_name" {
  description = "Name of the custom role definition"
  value       = azurerm_role_definition.opscompanion_readonly.name
}

output "client_secret" {
  description = "Client secret for the application (sensitive - store securely)"
  value       = azuread_application_password.opscompanion_app_password.value
  sensitive   = true
}
