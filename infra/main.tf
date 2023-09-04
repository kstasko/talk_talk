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
  region = "us-east-2"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "talk-talk-accountName" {
  bucket = "talk-talk-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "talk-talk-${data.aws_caller_identity.current.account_id}"
    Environment = "Dev"
  }
}
