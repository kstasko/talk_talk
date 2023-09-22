variable "deploy_environment" {
  description = "Environment Name to Deploy to (e.g. 'Prod', 'Non-Prod')"
  type        = string
}

variable "s3_bucket_id" {
  description = "S3 Bucket Name to upload objects to"
  type        = string
}