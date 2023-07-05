
variable "name" {
  type        = string
  description = "The EC2 instance name."
  default     = "Jenkins Server"
}

variable "vpc_id" {
  type        = string
  description = "The VPC id."
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "public_subnets_id" {
  description = "The Public Subnet id."
  type        = list(any)
  default     = []
}

variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with Jenkins Instance."
  type        = string
  default     = "JENKINS"
}

variable "security_groups_ids" {
  description = "The VPC security groups ids."
  type        = list(any)
  default     = []
}

variable "shared_tags" {
  description = "A map of tags to add to Jenkins Server."
  type        = map(string)
  default     = {}
}

