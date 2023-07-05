output "ec2_instance_public_ips" {
  description = "EC2 Instance Public IP."
  value       = [aws_instance.jenkins_server[*].public_ip]
}

output "ec2_instance_ids" {
  description = "EC2 Instance Ids."
  value       = [aws_instance.jenkins_server.id]
}
