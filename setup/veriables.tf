variable "region" {
  description = "The name of the aws Region."
  type        = string
  default     = "eu-central-1"
}

variable "acl" {
  type        = string
  description = "Defaults to private."
  default     = "private"
}

variable "bucket_prefix" {
  type        = string
  description = "(required since we are not using 'bucket') Creates a unique bucket name beginning with the specified prefix."
  default     = "natanb-s3-bucket"
}
