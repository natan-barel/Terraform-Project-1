# Create the SNS topic
resource "aws_sns_topic" "sns_topic" {
  name = var.sns_name
}


resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn = aws_sns_topic.sns_topic.arn
  policy = jsonencode(
    {
      Id = "ID-GD-Topic-Policy"
      Statement = [
        {
          Action = "sns:Publish"
          Effect = "Allow"
          Principal = {
            Service = "events.amazonaws.com"
          }
          Resource = aws_sns_topic.sns_topic.arn
          Sid      = "SID-GD-Example"
        },
      ]
      Version = "2012-10-17"
    }
  )
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn              = aws_sns_topic.sns_topic.arn
  protocol               = "email"
  endpoint               = var.email
  endpoint_auto_confirms = true
}

