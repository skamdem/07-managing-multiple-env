# terraform and providers versions
# and backend setup for the root module

terraform {
  required_version = ">= 1.5.0"

  # Remote backend specified as S3 bucket
  backend "s3" {
    bucket         = "devops-demos-terraform-state-bucket"
    key            = "07-managing-multiple-environments/workspaces/terraform.tfstate" # Matches repo name.
    region         = "us-east-1"
    dynamodb_table = "devops-demos-tfstate-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.6.2"
    }
  }
}