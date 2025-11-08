# Data source to get current project details
data "google_project" "project" {
  project_id = var.project_id
}

# Local variables
locals {
  # Service account name pattern: ops-${project_id}-sa
  service_account_name = "ops-${var.project_id}-sa"
  service_account_email = "${local.service_account_name}@${var.project_id}.iam.gserviceaccount.com"

  # Viewer roles to grant at project level
  viewer_roles = [
    "roles/viewer",
    # Uncomment additional roles as needed:
    # "roles/iam.securityReviewer",
    # "roles/resourcemanager.organizationViewer",
    # "roles/billing.viewer",
    # "roles/logging.viewer",
    # "roles/monitoring.viewer",
    # "roles/compute.viewer",
    # "roles/storage.objectViewer",
    # "roles/bigquery.dataViewer",
    # "roles/cloudsql.viewer",
    # "roles/container.viewer",
    # "roles/cloudkms.viewer",
    # "roles/secretmanager.viewer",
    # "roles/dns.reader",
    # "roles/networkmanagement.viewer",
    # "roles/cloudtrace.user",
    # "roles/errorreporting.viewer",
    # "roles/serviceusage.serviceUsageViewer",
    # "roles/cloudasset.viewer",
  ]

  # Workload Identity Pool principal sets
  workload_identity_principals = [
    "principalSet://iam.googleapis.com/projects/959129989827/locations/global/workloadIdentityPools/opscompanion/attribute.custom_org_id/${var.custom_org_id}",
    "principalSet://iam.googleapis.com/projects/959129989827/locations/global/workloadIdentityPools/opscompanion/attribute.aws_role/opscompanion-gcp-agent",
  ]

  # APIs to enable
  services_to_enable = [
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "serviceusage.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "storage.googleapis.com",
    "bigquery.googleapis.com",
    "sql.googleapis.com",
    "container.googleapis.com",
    "cloudkms.googleapis.com",
    "secretmanager.googleapis.com",
    "dns.googleapis.com",
    "cloudtrace.googleapis.com",
    "clouderrorreporting.googleapis.com",
    "cloudasset.googleapis.com",
    "pubsub.googleapis.com",
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "servicenetworking.googleapis.com",
  ]

  # # Audit log filter for important services
  # audit_log_filter = <<-EOT
  #   (
  #     logName:("cloudaudit.googleapis.com%2Factivity"
  #              OR "cloudaudit.googleapis.com%2Fsystem_event")
  #   )
  #   AND protoPayload.serviceName:(
  #     "compute.googleapis.com"
  #     OR "iam.googleapis.com"
  #     OR "cloudresourcemanager.googleapis.com"
  #     OR "servicenetworking.googleapis.com"
  #     OR "dns.googleapis.com"
  #     OR "container.googleapis.com"
  #     OR "sqladmin.googleapis.com"
  #     OR "run.googleapis.com"
  #     OR "storage.googleapis.com"
  #     OR "pubsub.googleapis.com"
  #     OR "cloudkms.googleapis.com"
  #     OR "artifactregistry.googleapis.com"
  #     OR "monitoring.googleapis.com"
  #     OR "logging.googleapis.com"
  #   )
  # EOT

  # # Pub/Sub topic details
  # pubsub_project_id = "opscompanion-ai"
  # pubsub_topic_name = "${var.project_id}-audit-logs"
}

# Enable required Google Cloud APIs
resource "google_project_service" "services" {
  for_each = toset(local.services_to_enable)

  project = var.project_id
  service = each.value

  disable_on_destroy = false
}

# Create the service account
resource "google_service_account" "ops_service_account" {
  project      = var.project_id
  account_id   = local.service_account_name
  display_name = "Project Viewer Service Account"
  description  = "Service account with comprehensive viewer access at project level"

  depends_on = [
    google_project_service.services
  ]
}

# Grant viewer roles at project level
resource "google_project_iam_member" "viewer_roles" {
  for_each = toset(local.viewer_roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.ops_service_account.email}"

  depends_on = [
    google_service_account.ops_service_account
  ]
}

# Grant Workload Identity Pool access to the service account
resource "google_service_account_iam_member" "workload_identity_user" {
  for_each = toset(local.workload_identity_principals)

  service_account_id = google_service_account.ops_service_account.name
  role               = "roles/iam.workloadIdentityUser"
  member             = each.value
}

# # Create Pub/Sub topic for audit logs in opscompanion-ai project
# resource "google_pubsub_topic" "audit_logs" {
#   project = local.pubsub_project_id
#   name    = local.pubsub_topic_name

#   labels = {
#     service    = "opscompanion"
#     managed-by = "terraform"
#   }
# }

# # Create audit log sink
# resource "google_logging_project_sink" "audit_logs" {
#   project = var.project_id
#   name    = "${var.project_id}-audit-sink"

#   destination = "pubsub.googleapis.com/projects/${local.pubsub_project_id}/topics/${local.pubsub_topic_name}"

#   filter = local.audit_log_filter

#   unique_writer_identity = true

#   depends_on = [
#     google_pubsub_topic.audit_logs
#   ]
# }

# # Grant Pub/Sub Publisher role to the log sink service account
# resource "google_pubsub_topic_iam_member" "sink_publisher" {
#   project = local.pubsub_project_id
#   topic   = local.pubsub_topic_name
#   role    = "roles/pubsub.publisher"
#   member  = google_logging_project_sink.audit_logs.writer_identity

#   depends_on = [
#     google_pubsub_topic.audit_logs,
#     google_logging_project_sink.audit_logs
#   ]
# }


