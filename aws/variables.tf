variable "role_name" {
  description = "Name of the IAM role to create"
  type        = string
  default     = "opscompanion-readonly-role"
}

variable "custom_org_id" {
  description = "Custom organization ID for tagging and identification"
  type        = string
}
