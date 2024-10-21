variable "destination_bucket_arn" {
  description = "The ARN of the destination bucket, where the data will be replicated."
  type        = string
}

variable "source_bucket_arn" {
  description = "The ARN of the source bucket, from which the data will be replicated."
  type        = string
}

variable "destination_account_id" {
  description = "The ID of the AWS account to which the data will be replicated."
  type        = string
}

variable "role_name" {
  description = "The name of the IAM role that will be created for the replication."
  type        = string
  default     = "s3-replication-from-s3-access-logs-bucket"
}

variable "policy_name" {
  description = "The name of the IAM policy that will be created for the replication."
  type        = string
  default     = "s3-replication-from-s3-access-logs-bucket"
}

variable "attach_region_name_to_role" {
  description = "Whether to attach the region name to the role name."
  type        = bool
  default     = true
}

variable "attach_region_name_to_policy" {
  description = "Whether to attach the region name to the policy name."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}
