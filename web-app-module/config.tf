# providers versions for the child module

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.6.2"
    }
  }
}