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
  bucket = "${var.deploy_environment}.talktalk.dev"
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.talk_talk_s3_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.talk_talk_s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.talk_talk_s3_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "AllowGetObjects"
    Statement = [
      {
        Sid       = "AllowPublic"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.talk_talk_s3_bucket.arn}/**"
      }
    ]
  })
}

output "s3_bucket_id" {
  value = aws_s3_bucket.talk_talk_s3_bucket.id
}
