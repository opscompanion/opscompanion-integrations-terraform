# Data source to get current AWS account details
data "aws_caller_identity" "current" {}

# Local variables
locals {
  # OpsCompanion scanner role ARN
  opscompanion_scanner_role_arn = "arn:aws:iam::703139106882:role/opscompanion-aws-scanner"

  # Tags for resources
  common_tags = {
    ManagedBy     = "terraform"
    Service       = "opscompanion"
    CustomOrgId   = var.custom_org_id
  }
}

# IAM assume role policy document for trust relationship
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [local.opscompanion_scanner_role_arn]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Create the IAM role
resource "aws_iam_role" "opscompanion_readonly" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  description        = "IAM role with read-only access for OpsCompanion integration"

  tags = merge(
    local.common_tags,
    {
      Name = var.role_name
    }
  )
}

# Attach AWS managed ReadOnlyAccess policy
resource "aws_iam_role_policy_attachment" "readonly_access" {
  role       = aws_iam_role.opscompanion_readonly.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
