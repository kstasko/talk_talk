terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 1.2.0"
}

resource "aws_s3_bucket" "talk_talk_s3_bucket" {
  bucket = "talk-talk-${var.deploy_environment}"
}

resource "aws_s3_object" "object" {
  for_each = fileset("../app/build/", "*")
  bucket   = aws_s3_bucket.talk_talk_s3_bucket.id
  key      = each.value
  source   = "../app/build/${each.value}"
  etag     = filemd5("../app/build/${each.value}"
}