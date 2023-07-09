variable "sns_topic_arn" {}

variable "instance_ids" {
  description = "list of instances ids"
  type        = list(any)
}
