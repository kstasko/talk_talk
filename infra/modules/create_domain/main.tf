terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 1.2.0"
}

resource "aws_route53_zone" "talk-talk-route53-zone" {
  name = var.domain_name
}
