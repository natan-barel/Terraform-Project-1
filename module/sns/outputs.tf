output "sns_topic_arn" {
  value       = aws_sns_topic.sns_topic.arn
  description = "Output of ARN to call in the eventbridge rule."
}
