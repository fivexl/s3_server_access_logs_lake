resource "aws_iam_role" "replication" {
  name = local.role_name

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "s3.amazonaws.com"
          },
          "Effect" : "Allow",
          "Sid" : "AssumeForS3"
        }
      ]
    }
  )
}

resource "aws_iam_policy" "replication" {
  name = local.policy_name

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "s3:GetReplicationConfiguration",
            "s3:ListBucket"
          ],
          "Effect" : "Allow",
          "Resource" : [var.source_bucket_arn]
        },
        {
          "Action" : [
            "s3:GetObjectVersion",
            "s3:GetObjectVersionAcl"
          ],
          "Effect" : "Allow",
          "Resource" : [
            "${var.source_bucket_arn}/*"
          ]
        },
        {
          "Action" : [
            "s3:ReplicateObject",
          ],
          "Effect" : "Allow",
          "Resource" : "${var.destination_bucket_arn}/*"
        }
      ]
    }
  )
  tags = var.tags
}

resource "aws_iam_policy_attachment" "replication" {
  name       = "s3-replication-from-s3-access-logs-bucket"
  roles      = [aws_iam_role.replication.name]
  policy_arn = aws_iam_policy.replication.arn
}