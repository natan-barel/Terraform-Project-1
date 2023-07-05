resource "aws_iam_role" "jenkins_scheduler_role" {
  name = "jenkins-scheduler-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "sts:AssumeRole"
        ],
        "Principal" : {
          "Service" : [
            "scheduler.amazonaws.com"
          ]
        }
      }
    ]
  })
  tags = merge({
    Name : "Jenkins Scheduler Role"
  }, local.tags)
}


resource "aws_iam_policy" "StartStopEc2Instances" {
  name        = "StartStopPolicyInstances"
  description = "Allows Amazon EventBridge to start and stop ec2 instances"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "StartStopEc2",
        "Effect" : "Allow",
        "Action" : [
          "ec2:StopInstances",
          "ec2:StartInstances"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_scheduler_policy" {
  policy_arn = aws_iam_policy.StartStopEc2Instances.arn
  role       = aws_iam_role.jenkins_scheduler_role.name
}
