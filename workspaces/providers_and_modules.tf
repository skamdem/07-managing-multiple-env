# list of providers

provider "aws" {
  region = var.region
}

locals {
  environment_name = terraform.workspace
}

module "web_app" {
  source = "../web-app-module"

  # Input variables (instead of "terraform.tfvars" 
  # file in the previous configuration)
  bucket_prefix     = "devops-web-app-${local.environment_name}"
  create_dns_record = true
  subdomain         = "devops"
  domain            = "skamdem.dev"
  db_name           = "${local.environment_name}_db"
  db_pass           = var.db_pass
  db_user           = "foo"
  environment_name  = local.environment_name
  instance_type     = "t2.micro"
}
