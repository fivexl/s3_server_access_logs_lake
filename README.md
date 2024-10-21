# Terraform-aws-s3-server-access-logs-lake
This repository contains Terraform modules for setting up a centralized log-archive account for server access logs from multiple accounts in an AWS Organization. The modules are designed to replicate logs from various accounts to a designated log-archive account, where they can be stored and queried for further analysis.


# Terraform AWS S3 Server Access Logs Lake Delivery Configuration Module
This module simplifies the replication of server access logs from multiple accounts in an AWS Organization to a centralized log-archive account. It provisions an IAM role and policy for S3 bucket replication and configures cross-account replication for log delivery.

### Features:
- IAM role and policy for S3 replication
- Replication configuration for cross-account log delivery

### Usage:
Utilize this module to replicate server access logs from various accounts in your AWS Organization to a designated log-archive account. Provide the following inputs:
- `source_bucket_arn`
- `destination_account_id`
- `destination_bucket_arn`

This will set up the necessary replication configuration to transfer logs to the log-archive bucket.

---

# Terraform AWS S3 Server Access Logs Target Module
This module provisions an S3 bucket specifically designed to store replicated access logs from multiple S3 buckets in other accounts within your AWS Organization.

### Features:
- Creates an S3 bucket using FivexL's `s3_baseline` module, designed to serve as the target for log replication
- Configures a bucket policy that permits the replication of logs from other accounts in the organization
- Creates a Glue table for querying logs via Athena

### Usage:
Deploy this module in the log-archive account. The resulting S3 bucket will serve as the target for logs replicated from other accounts. Each account in the organization will only be able to write logs to their respective prefix (e.g., `arn:aws:s3:::${bucket_name}/$${aws:PrincipalAccount}/*`).

The generated Glue table enables querying of the logs via AWS Athena for further analysis.

---

## Review Links

- [Review recent changes](https://github.com/fivexl/terraform-aws-s3-server-access-logs-lake/compare/main@%7B7day%7D...main)
- [Branch-based review](https://github.com/fivexl/terraform-aws-s3-server-access-logs-lake/compare/review...main)
