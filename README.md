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

## Support
Have questions or feedback? We're here to help:

- Email: [support@opscompanion.ai](mailto:support@opscompanion.ai)
- Discord: [Join our Discord server](https://discord.com/invite/7FKTdScyJm)
- Documentation: [opscompanion.ai/docs](https://opscompanion.ai/docs)

## Coming Soon

- Azure
- Oracle Cloud
- DigitalOcean


## Updates & Roadmap
Stay up to date with the latest improvements:

- [Changelog](https://opscompanion.ai/docs/changelog)
- [X](https://x.com/OpsCompanion)
- [Linkedin](https://www.linkedin.com/company/opscompanion/)
