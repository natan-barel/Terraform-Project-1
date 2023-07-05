locals {
  region             = "us-east-1"
  availability_zones = ["${local.region}a"]
  tags = {
    "Environment" : "DEV"
    "Project" : "Terraform Project 1"
  }
}
