provider "aws" {
  region = local.region
}

module "Networking" {
  source             = "../../module/networking"
  name               = "Terraform Project 1 VPC"
  availability_zones = local.availability_zones
  vpc_cidr_block     = "10.0.0.0/16"
  # public_subnets_cidr_block = ["10.0.32.0/24", "10.0.96.0/24", "10.0.224.0/24"]
  public_subnets_cidr_block = ["10.0.0.0/24"]
  # private_subnets_cidr_block = ["10.0.0.0/19", "10.0.64.0/19", "10.0.128.0/19"]
  vpc_tags = local.tags
}

module "Jenkins" {
  source              = "../../module/jenkins"
  name                = "Terraform Project 1 Jenkins"
  vpc_id              = module.Networking.vpc_id
  public_subnets_id   = module.Networking.public_subnets_id
  security_groups_ids = module.Networking.security_groups_ids
  shared_tags         = local.tags
}

module "Scheduler" {
  source       = "../../module/scheduler"
  instance_ids = module.Jenkins.ec2_instance_ids
}
