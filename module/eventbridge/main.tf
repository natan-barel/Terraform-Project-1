# EVENT RULE RESOURCE
resource "aws_cloudwatch_event_rule" "jenkins-instance-start-stop" {
  name = "jenkins-EC2-start-stop"

  event_pattern = <<EOF
{
  "source": ["aws.ec2"],
  "detail-type": ["EC2 Instance State-change Notification"],
  "detail": {
    "state": ["running", "stopped"],
    "instance-id": ["${local.instance_ids[0]}"]
  }
}
 EOF
}

# EVENT TARGET RESOURCE FOR SNS NOTIFICATIONS
resource "aws_cloudwatch_event_target" "sns" {

  rule      = aws_cloudwatch_event_rule.jenkins-instance-start-stop.name
  target_id = "Jenkins-EC2-Start-Stop"
  arn       = var.sns_topic_arn

  input_transformer {
    input_paths = {
      instance = "$.detail.instance",
      status   = "$.detail.status",
    }
    input_template = <<EOF
{
  "instance_id": <instance>,
  "instance_status": <status>
}
EOF
  }
}

