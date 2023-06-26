# list of providers

provider "aws" {
  region = var.region
}

# the hosted zone is assumed to exist already
data "aws_route53_zone" "my_zone" {
  name = var.domain
}

locals {
  environment_name    = terraform.workspace //dev/staging/production
  prefix_of_subdomain = local.environment_name == "production" ? "" : "${local.environment_name}-"
  subdomain           = "${local.prefix_of_subdomain}${var.app_name}"
  bucket_prefix       = "${local.subdomain}-bucket"
  db_name             = replace("${local.subdomain}-db", "-", "") //remove hyphens from db name
}

check "valid_environment" {
  // verify environment is one of dev/staging/production
  assert {
    condition     = local.environment_name == "dev" || local.environment_name == "staging" || local.environment_name == "production"
    error_message = "The workspace must be either of:  \"dev\", \"staging\" OR \"production\"."
  }
}

module "web_app" {
  source = "../web-app-module"

  # Input variables
  app_name          = var.app_name
  bucket_prefix     = local.bucket_prefix
  create_dns_record = true
  create_db_and_s3  = var.create_db_and_s3
  domain            = var.domain
  subdomain         = local.subdomain
  db_name           = local.db_name
  db_pass           = var.db_pass
  db_user           = var.db_user
  environment_name  = terraform.workspace
  instance_ami      = var.instance_ami
  instance_type     = var.instance_type
  certificate_arn   = module.acm.acm_certificate_arn
}

# Module to create and validate the AWS certificate
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.3.2"

  domain_name = var.domain
  zone_id     = data.aws_route53_zone.my_zone.id

  subject_alternative_names = [
    "*.${var.domain}",
    "${local.subdomain}.${var.domain}",
  ]

  wait_for_validation = true

  tags = {
    Name = "${var.domain}"
  }
}
