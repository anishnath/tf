output "iam_role_name" {
  description = "Name of IAM role"
  value       = module.iam_assumable_role_custom.iam_role_name
}