# Terraform AWS S3 Server Access Logs Lake Delivery Configuration Module
This module provides an IAM role and policy for S3 bucket replication, along with replication configuration for replicating logs from other accounts in the organization to the log-archive account.

### Features:
- IAM role & policy for S3 bucket replication
- Replication configuration

### Usage:
Use this module if you need to replicate logs from other accounts in the organization to the log-archive account. Provide this module with `source_bucket_arn`, `destination_account_id`, and `destination_bucket_arn` to obtain the replication configuration for the bucket.

### Examples:

```hcl
module "s3_server_access_logs_lake_delivery_configuration_primary" {
  source = "fivexl/terraform-aws-s3-server-access-logs-lake/aws//modules/delivery_configuration"

  source_bucket_arn      = "arn:aws:s3:::<bucket_name>"
  destination_account_id = module.s3_access_logs_replication_configuration_primary.account_id
  destination_bucket_arn = module.s3_access_logs_replication_configuration_primary.bucket_arn
  providers              = { aws = aws.primary }

  tags = var.config.tags
}

module "account_baseline_region_level_primary" {
  source  = "fivexl/account-baseline/aws//modules/region_level"
  version = "1.2.3"

  s3_access_logs_bucket_replication_configuration = module.s3_server_access_logs_lake_delivery_configuration_primary[0].replication_configuration
  s3_access_logs_bucket_lifecycle_rule            = local.logs_bucket_lifecycle_rule

  tags      = var.config.tags
  providers = { aws = aws.primary }
}
module "s3_server_access_logs_lake_delivery_configuration_secondary" {
  source = "fivexl/terraform-aws-s3-server-access-logs-lake/aws//modules/delivery_configuration"

  source_bucket_arn      = "arn:aws:s3:::<bucket_name>"
  destination_account_id = module.s3_access_logs_replication_configuration_secondary.account_id
  destination_bucket_arn = module.s3_access_logs_replication_configuration_secondary.bucket_arn

  providers = { aws = aws.secondary }
  tags      = var.config.tags
}

module "account_baseline_region_level_secondary" {
  source  = "fivexl/account-baseline/aws//modules/region_level"
  version = "1.2.3"

  s3_access_logs_bucket_replication_configuration = module.s3_server_access_logs_lake_delivery_configuration_secondary[0].replication_configuration
  s3_access_logs_bucket_lifecycle_rule            = local.logs_bucket_lifecycle_rule

  tags      = var.config.tags
  providers = { aws = aws.secondary }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_region_name_to_policy"></a> [attach\_region\_name\_to\_policy](#input\_attach\_region\_name\_to\_policy) | Whether to attach the region name to the policy name. | `bool` | `true` | no |
| <a name="input_attach_region_name_to_role"></a> [attach\_region\_name\_to\_role](#input\_attach\_region\_name\_to\_role) | Whether to attach the region name to the role name. | `bool` | `true` | no |
| <a name="input_destination_account_id"></a> [destination\_account\_id](#input\_destination\_account\_id) | The ID of the AWS account to which the data will be replicated. | `string` | n/a | yes |
| <a name="input_destination_bucket_arn"></a> [destination\_bucket\_arn](#input\_destination\_bucket\_arn) | The ARN of the destination bucket, where the data will be replicated. | `string` | n/a | yes |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the IAM policy that will be created for the replication. | `string` | `"s3-replication-from-s3-access-logs-bucket"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of the IAM role that will be created for the replication. | `string` | `"s3-replication-from-s3-access-logs-bucket"` | no |
| <a name="input_source_bucket_arn"></a> [source\_bucket\_arn](#input\_source\_bucket\_arn) | The ARN of the source bucket, from which the data will be replicated. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to IAM role resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_replication_configuration"></a> [replication\_configuration](#output\_replication\_configuration) | n/a |
| <a name="output_replication_role_arn"></a> [replication\_role\_arn](#output\_replication\_role\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
