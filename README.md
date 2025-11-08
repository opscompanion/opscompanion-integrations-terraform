# OpsCompanion Cloud Integrations (Terraform)

Cloud provider integrations for OpsCompanion managed via Terraform.

## GCP Integration

```hcl
module "opscompanion-gcp-integration" {
  source = "github.com/opscompanion/opscompanion-integrations-terraform/gcp"

  project_id    = "your-project-id"
  custom_org_id = "your-org-id"
}

output "service_account_email" {
  value = module.opscompanion-gcp-integration.service_account_email
}
```

## Coming Soon

- AWS
- Azure
- Oracle Cloud
- DigitalOcean