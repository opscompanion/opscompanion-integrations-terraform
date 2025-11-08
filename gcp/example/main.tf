module "gcp_integration" {
  source = "../"

  project_id    = "named-signal-467610-d5"
  custom_org_id = "kenneth-org"
}

output "service_account_email" {
  value = module.gcp_integration.service_account_email
}

# output "pubsub_topic" {
#   value = module.gcp_integration.pubsub_topic_full_path
# }
