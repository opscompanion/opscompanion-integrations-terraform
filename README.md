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

## AWS Integration

```hcl
module "opscompanion-aws-integration" {
  source = "github.com/opscompanion/opscompanion-integrations-terraform/aws"

  role_name     = "opscompanion-readonly-role"  # Optional, defaults to this value
  custom_org_id = "your-org-id"
}

output "role_arn" {
  value = module.opscompanion-aws-integration.role_arn
}
```

## Coming Soon

- Azure
- Oracle Cloud
- DigitalOcean