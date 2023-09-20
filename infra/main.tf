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

module "create_subdomain" {
  source = "./modules/create_domain"

  domain_name = "${var.deploy_environment}.talktalk.dev"
}

module "create_s3_bucket" {
  source = "./modules/create_s3_bucket"

  deploy_environment = var.deploy_environment
}

module "upload_build" {
  source = "./modules/upload_build"

  deploy_environment = var.deploy_environment
  s3_bucket_id       = module.create_s3_bucket.s3_bucket_id
}

module "create_cloudfront" {
  source = "./modules/create_cloudfront"

  s3_bucket_id = module.create_s3_bucket.s3_bucket_id
  region       = "us-east-2"
}


resource "aws_route53_record" "a_record" {
  zone_id = module.create_subdomain.hosted_zone_id
  name    = "${var.deploy_environment}.talktalk.dev"
  type    = "A"
  ttl     = "30"
  records = [module.create_cloudfront.cloudfront_domain_name]
}

