output "replication_configuration" {
  value = local.replication_configuration
}

output "replication_role_arn" {
  value = aws_iam_role.replication.arn
}