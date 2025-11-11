output "role_arn" {
  description = "ARN of the created IAM role"
  value       = aws_iam_role.opscompanion_readonly.arn
}

output "role_name" {
  description = "Name of the created IAM role"
  value       = aws_iam_role.opscompanion_readonly.name
}

output "role_id" {
  description = "ID of the created IAM role"
  value       = aws_iam_role.opscompanion_readonly.id
}

output "account_id" {
  description = "AWS account ID where the role was created"
  value       = data.aws_caller_identity.current.account_id
}
