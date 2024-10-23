moved {
  from = module.targets_bucket
  to   = module.target_bucket
}

moved {
  from = module.target_bucket_access_logs_bucket
  to   = module.target_bucket_access_logs_bucket[0]
}