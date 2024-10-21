locals {
  env_id = sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))

  uuid = local.env_id

  kebab_case_region = replace(data.aws_region.current.name, "-", "_") # kebab-case to snake_case
  glue_table_name   = "s3_server_access_logs_${local.kebab_case_region}"

  # Isnpired by Security Lake S3 bucket name format:
  # 'aws-security-data-lake-{region}-{uuid}'
  # sample: 'aws-security-data-lake-ap-northeast-1-mihrqxodzqrpxy1ekyccsmcty'
  full_bucket_name                           = "s3-server-access-logs-${data.aws_region.current.name}-${local.uuid}"
  full_target_bucket_access_logs_bucket_name = "replication-bucket-access-logs-${data.aws_region.current.name}-${local.uuid}"

  // Truncate to ensure it's 63 characters or fewer
  bucket_name                           = length(local.full_bucket_name) > 63 ? substr(local.full_bucket_name, 0, 63) : local.full_bucket_name
  target_bucket_access_logs_bucket_name = length(local.full_target_bucket_access_logs_bucket_name) > 63 ? substr(local.full_target_bucket_access_logs_bucket_name, 0, 63) : local.full_target_bucket_access_logs_bucket_name
}
