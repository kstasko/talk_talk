variable "aws_region" {
  description = "AWS Region for Deployment (e.g. 'us-east-2')"
  type        = string
  default     = "us-east-2"
  validation {
    condition     = contains(["us-east-1", "us-east-2"], var.aws_region)
    error_message = "AWS Region ('aws_region') must be one of ['us-east-1', 'us-east-2']"
  }
}

variable "aws_account" {
  description = "AWS Workflow Account ID"
  type        = number
}

variable "aws_role_arn" {
  description = "AWS Role Arn"
  type        = string
  validation {
    condition     = can(regex("^arn:aws:iam::\\d{12}:role\\/[A-Za-z0-9]+(?:-[A-Za-z0-9]+)+$", var.aws_role_arn))
    error_message = "Please input valid role arn for AWS"
  }
}

variable "deploy_environment" {
  description = "Environment Name to Deploy to (e.g. 'Prod', 'Non-Prod')"
  type        = string
}


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
}

resource "aws_s3_bucket" "talk-talk-s3-bucket" {
  bucket = "talk-talk-${var.deploy_environment}"


  tags = {
    Name        = "talk-talk-${var.deploy_environment}"
    Environment = var.deploy_environment
  }
}
