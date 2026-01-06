terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  // Compatible with latest; update to ~> 6.0 if desired
    }
  }
}

provider "aws" {
  region = var.region
}