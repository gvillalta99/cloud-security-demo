terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region = var.region
}
locals {
  subnets         = cidrsubnets(var.cidr_block, var.newbits, var.newbits, var.newbits, var.newbits)
  private_subnets = length(var.cidr_private_subnets) > 0 ? var.cidr_private_subnets : slice(local.subnets, 0, 1)
  public_subnets  = length(var.cidr_public_subnets) > 0 ? var.cidr_public_subnets : slice(local.subnets, 2, 3)
  azs_count       = length(var.availability_zones)
}
