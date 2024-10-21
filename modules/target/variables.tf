variable "glue_database_name" {
  description = "The name of the Glue database to create for the S3 access logs."
  type        = string
}

variable "tags" {
  description = "(Optional) Key-value map of resource tags"
  type        = map(string)
  default     = {}
}

variable "logs_bucket_lifecycle_rule" {
  type        = any
  description = "The lifecycle rule for the logs bucket"
  default     = {}
}

variable "target_bucket_name" {
  type        = string
  description = "The name of the target bucket. If not provided, the bucket name will be generated based on the region and UUID."
  default     = null
}

variable "target_bucket_access_logs_bucket_name" {
  type        = string
  description = "Name for a backet that would be used to store access logs of the target bucket."
  default     = null
}