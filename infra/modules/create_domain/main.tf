terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 1.2.0"
}

data "aws_route53_zone" "this" {
  name = "talktalk.dev"
}

resource "aws_route53_zone" "stage-hosted-zone" {
  name = "${var.domain_name}.talktalk.dev"
}

resource "aws_route53_record" "stage-ns-record" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "${var.domain_name}.talktalk.dev"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.stage-hosted-zone.name_servers
}

output "hosted_zone_id" {
  value = aws_route53_zone.stage-hosted-zone.id
}

