# Data source to get current Azure AD config
data "azuread_client_config" "current" {}

# Data source to get subscription details
data "azurerm_subscription" "current" {}

# Local variables
locals {
  # Custom role name with read-only permissions
  custom_role_name = var.custom_role_name

  # Comprehensive read-only permissions for Azure resources
  custom_role_permissions = [
    "*/read",
    "Microsoft.Authorization/*/read",
    "Microsoft.Insights/alertRules/read",
    "Microsoft.operationalInsights/workspaces/*/read",
    "Microsoft.Resources/deployments/*/read",
    "Microsoft.Resources/subscriptions/resourceGroups/read",
    "Microsoft.Security/*/read",
    "Microsoft.IoTSecurity/*/read",
    "Microsoft.Support/*/read",
    "Microsoft.Security/iotDefenderSettings/packageDownloads/action",
    "Microsoft.Security/iotDefenderSettings/downloadManagerActivation/action",
    "Microsoft.Security/iotSensors/downloadResetPassword/action",
    "Microsoft.IoTSecurity/defenderSettings/packageDownloads/action",
    "Microsoft.IoTSecurity/defenderSettings/downloadManagerActivation/action",
    "Microsoft.Management/managementGroups/read",
    "Microsoft.ContainerRegistry/registries/listCredentials/action"
  ]

  # Tags for resources
  common_tags = {
    ManagedBy   = "terraform"
    Service     = "opscompanion"
    CustomOrgId = var.custom_org_id
  }
}

# Generate random suffix for unique app name
resource "random_string" "app_postfix" {
  length  = 4
  special = false
  upper   = false
  lower   = true
  numeric = true
}

# Create Azure AD application registration
resource "azuread_application_registration" "opscompanion_app" {
  display_name = "${var.app_name}-${random_string.app_postfix.result}"
}

# Create service principal for the application
resource "azuread_service_principal" "opscompanion_sp" {
  client_id   = azuread_application_registration.opscompanion_app.client_id
  description = "OpsCompanion integration service principal with read-only access"

  tags = values(local.common_tags)
}

# Create application password (client secret) for authentication
resource "azuread_application_password" "opscompanion_app_password" {
  application_id = azuread_application_registration.opscompanion_app.id
  display_name   = "OpsCompanion Client Secret"
  end_date       = timeadd(timestamp(), "26280h") # 3 years
}

# Create custom role definition with read-only permissions
resource "azurerm_role_definition" "opscompanion_readonly" {
  name        = "${local.custom_role_name}-${random_string.app_postfix.result}"
  scope       = data.azurerm_subscription.current.id
  description = "Custom read-only role for OpsCompanion integration"

  permissions {
    actions     = local.custom_role_permissions
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id
  ]
}

# Assign custom role to service principal at subscription level
resource "azurerm_role_assignment" "opscompanion_assignment" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = azurerm_role_definition.opscompanion_readonly.role_definition_resource_id
  principal_id       = azuread_service_principal.opscompanion_sp.object_id
}
