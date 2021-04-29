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
  azs    = ["us-east-1a", "us-east-1c"]
  tags = {
    Curso      = "MBA - CYBERSECURITY"
    Disciplina = "CLOUD COMPUTING SECURITY, DEVOPS E DEVSECOPS "
    Turma      = "55SEG"
  }
}

module "network" {
  source                   = "./network"
  region                   = local.region
  availability_zones       = local.azs
  cidr_block               = "172.20.0.0/24"
  cidr_public_subnets      = ["172.20.0.0/28", "172.20.0.16/28"]
  cidr_private_app_subnets = ["172.20.0.32/28", "172.20.0.48/28"]
  cidr_private_db_subnets  = ["172.20.0.64/28", "172.20.0.80/28"]
  tags                     = local.tags
}

module "application" {
  source             = "./application"
  region             = local.region
  availability_zones = local.azs
  tags               = local.tags

  name              = "example-app"
  image_id          = "ami-07d8fdf67385ad60e"
  instance_type     = "t2.micro"
  subnet_app_ids    = module.network.private_app_subnet_ids
  subnet_public_ids = module.network.public_subnet_ids
  vpc_id            = module.network.vpc_id

  capacity = {
    max     = 2
    min     = 1
    desired = 1
  }
}
