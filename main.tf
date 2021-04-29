terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.37.0"
    }
  }
  required_version = ">= 0.15"
}

locals {
  region = "us-east-1"
  tags = {
    Curso      = "MBA - CYBERSECURITY"
    Disciplina = "CLOUD COMPUTING SECURITY, DEVOPS E DEVSECOPS "
    Turma      = "55SEG"
  }
}

module "network" {
  source                   = "./network"
  region                   = local.region
  cidr_block               = "172.20.0.0/24"
  cidr_public_subnets      = ["172.20.0.0/28", "172.20.0.16/28"]
  cidr_private_app_subnets = ["172.20.0.32/28", "172.20.0.48/28"]
  cidr_private_db_subnets  = ["172.20.0.64/28", "172.20.0.80/28"]
  availability_zones       = ["us-east-1a", "us-east-1c"]
  tags                     = local.tags
}
