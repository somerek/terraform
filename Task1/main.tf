terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Owner = "Roman_Popov3@epam.com"
    }
  }
}

// Get VPCs
data "aws_vpcs" "my_vpcs" {}

// Get Subnets
data "aws_subnets" "my_subnets" {}

// Get Security Groups
data "aws_security_groups" "my_sg" {}
