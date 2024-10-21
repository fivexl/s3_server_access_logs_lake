locals {
  role_name   = var.attach_region_name_to_role ? "${data.aws_region.current.name}-${var.role_name}" : var.role_name
  policy_name = var.attach_region_name_to_policy ? "${data.aws_region.current.name}-${var.policy_name}" : var.policy_name
  replication_configuration = {
    role = aws_iam_role.replication.arn

    rules = [
      {
        id       = "log-archive"
        status   = true
        priority = 0

        delete_marker_replication = false
        source_selection_criteria = {
          replica_modifications = {
            status = "Enabled"
          }
        }

        destination = {
          bucket        = var.destination_bucket_arn
          storage_class = "STANDARD"
          account_id    = var.destination_account_id

          access_control_translation = {
            owner = "Destination"
          }
        }
      },
    ]
  }
}
