resource "aws_scheduler_schedule" "start_scheduler" {
  name       = "jenkins-scheduler-start"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  # Run it at 7AM
  schedule_expression = local.start_schedule

  target {
    # This indicates that the event should be send to EC2 API and startInstances action should be triggered
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:startInstances"
    role_arn = aws_iam_role.jenkins_scheduler_role.arn

    # And this block will be passed to startInstances API
    input = jsonencode({
      InstanceIds = local.instance_ids
    })
  }
}

resource "aws_scheduler_schedule" "stop_scheduler" {
  name       = "jenkins-scheduler-stop"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  # Stop it at 7PM
  schedule_expression = local.stop_schedule

  target {
    # This indicates that the event should be send to EC2 API and stopInstances action should be triggered
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
    role_arn = aws_iam_role.jenkins_scheduler_role.arn

    # And this block will be passed to stopInstances API
    input = jsonencode({
      InstanceIds = local.instance_ids
    })
  }
}

