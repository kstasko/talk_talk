terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  region = "us-east-2"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "talk-talk-s3-bucket" {
  bucket = "talk-talk-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "talk-talk-${data.aws_caller_identity.current.account_id}"
    Environment = "Dev"
  }
}
