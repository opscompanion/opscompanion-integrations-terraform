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


## Azure Integration

```hcl
module "opscompanion-azure-integration" {
  source = "github.com/opscompanion/opscompanion-integrations-terraform/azure"

  subscription_id   = "your-subscription-id"
  custom_org_id     = "your-org-id"
  app_name          = "opscompanion-readonly-app"           # Optional, defaults to this value
  custom_role_name  = "OpsCompanion Custom Reader Role"     # Optional, defaults to this value
}

output "application_id" {
  value = module.opscompanion-azure-integration.application_id
}

output "tenant_id" {
  value = module.opscompanion-azure-integration.tenant_id
}

output "client_secret" {
  value     = module.opscompanion-azure-integration.client_secret
  sensitive = true
}

output "service_principal_id" {
  value = module.opscompanion-azure-integration.service_principal_id
}
```

## Coming Soon

- Oracle Cloud
- DigitalOcean

## Support
Have questions or feedback? We're here to help:

- Email: [support@opscompanion.ai](mailto:support@opscompanion.ai)
- Discord: [Join our Discord server](https://discord.com/invite/7FKTdScyJm)
- Documentation: [opscompanion.ai/docs](https://opscompanion.ai/docs)

## Updates & Roadmap
Stay up to date with the latest improvements:

- [Changelog](https://opscompanion.ai/docs/changelog)
- [X](https://x.com/OpsCompanion)
- [Linkedin](https://www.linkedin.com/company/opscompanion/)
