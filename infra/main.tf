terraform {
  backend "s3" {
    bucket = "talk-talk-terraform-state-storage"
    key    = "${var.deploy_environment}/terraform.tfstate"
    region = "us-east-2"
  }
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

module "create_subdomain" {
  source = "./modules/create_domain"

  domain_name = "${var.deploy_environment}.talktalk.dev"
}

resource "aws_s3_bucket" "talk_talk_s3_bucket" {
  bucket = "talk-talk-${var.deploy_environment}"
}
