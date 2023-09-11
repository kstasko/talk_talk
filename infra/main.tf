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
  assume_role {
    role_arn = var.aws_role_arn
  }
  region = var.aws_region
  default_tags {
    tags = {
      Environment = var.deploy_environment
    }
  }
}

resource "aws_route53_zone" "talk-talk-route53-zone" {
  name = var.domain_name
}


resource "aws_s3_bucket" "talk-talk-s3_bucket" {
  bucket = "talk-talk-${var.deploy_environment}"
}
