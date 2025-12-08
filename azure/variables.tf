variable "subscription_id" {
  description = "The Azure subscription ID where resources will be created"
  type        = string
}

variable "app_name" {
  description = "Name of the Azure AD application registration"
  type        = string
  default     = "opscompanion-readonly-app"
}

variable "custom_role_name" {
  description = "Name of the custom role with read-only permissions"
  type        = string
  default     = "OpsCompanion Custom Reader Role"
}

variable "custom_org_id" {
  description = "OpsCompanion organization public ID for tagging"
  type        = string
}

