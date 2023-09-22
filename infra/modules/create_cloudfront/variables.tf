variable "acm_certificate_arn" {
  description = "ACM Certificate ARN"
  type        = string
}

variable "deploy_environment" {
  description = "Environment Name to Deploy to (e.g. 'Prod', 'Non-Prod')"
  type        = string
}
variable "region" {
  description = "Environment Name to Deploy to (e.g. 'Prod', 'Non-Prod')"
  type        = string
}

variable "s3_bucket_id" {
  description = "S3 Bucket Id"
  type        = string
}