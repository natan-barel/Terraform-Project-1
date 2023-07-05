locals {
  vpc_id              = var.vpc_id
  name                = var.name
  instance_type       = var.instance_type
  subnet_id           = var.public_subnets_id[0][0]
  tags                = var.shared_tags
  security_groups_ids = var.security_groups_ids
}
