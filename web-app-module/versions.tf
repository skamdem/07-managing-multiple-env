# providers versions for the child module

terraform {
  required_version = ">= 1.5.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.6.2"
    }
  }
}