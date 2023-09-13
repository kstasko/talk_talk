terraform {
  backend "s3" {
    bucket = "talk-talk-terraform-state-storage"
    key    = "terraform.tfstate"
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

# Look into this later ..
# https://github.com/kstasko/talk_talk/actions/runs/6140824849/job/16660295312
#module "create_base_domain" {
#  source = "./modules/create_domain"
#
#  domain_name = "talktalk.dev"
#}

resource "aws_s3_bucket" "talk_talk_s3_bucket" {
  bucket = "talk-talk-${var.deploy_environment}"
}
