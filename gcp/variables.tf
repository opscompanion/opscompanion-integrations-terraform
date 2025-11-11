variable "project_id" {
  description = "The GCP project ID to manage"
  type        = string
}

variable "custom_org_id" {
  description = "Custom organization ID for Workload Identity Pool principal set"
  type        = string
}
