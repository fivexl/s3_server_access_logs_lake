# s3_server_access_logs_lake
This module contains two submodules: - target: S3 bucket where s3 server access logs will be replicated to. Should be deployed in a log-archive account. - delivery_configuration: IAM role and policy for S3 bucket replication to a log-archive account. Should be deployed in a source account.
