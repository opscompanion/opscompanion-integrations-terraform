output "service_account_email" {
  description = "Email address of the created service account"
  value       = google_service_account.ops_service_account.email
}

output "service_account_name" {
  description = "Name of the created service account"
  value       = google_service_account.ops_service_account.name
}

output "service_account_id" {
  description = "Fully qualified ID of the service account"
  value       = google_service_account.ops_service_account.id
}

output "project_id" {
  description = "The GCP project ID"
  value       = var.project_id
}

# output "pubsub_topic_name" {
#   description = "Name of the Pub/Sub topic for audit logs"
#   value       = google_pubsub_topic.audit_logs.name
# }

# output "pubsub_topic_full_path" {
#   description = "Full path to the Pub/Sub topic for audit logs"
#   value       = "projects/${local.pubsub_project_id}/topics/${local.pubsub_topic_name}"
# }

# output "log_sink_name" {
#   description = "Name of the audit log sink"
#   value       = google_logging_project_sink.audit_logs.name
# }

# output "log_sink_writer_identity" {
#   description = "Service account email for the log sink"
#   value       = google_logging_project_sink.audit_logs.writer_identity
# }
