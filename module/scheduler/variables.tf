variable "start_schedule" {
  description = "scheduler expression to start the instance."
  type        = string
  default     = "cron(0 07 * * ? *)"
}

variable "stop_schedule" {
  description = "scheduler expression to stop the instance."
  type        = string
  default     = "cron(0 19 * * ? *)"
}

variable "instance_ids" {
  description = "list of instances ids"
  type        = list(any)
}

variable "shared_tags" {
  description = "A map of tags to add to Scheduler."
  type        = map(string)
  default     = {}
}
