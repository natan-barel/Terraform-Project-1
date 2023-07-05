# Define the security group for Jenkins server.
resource "aws_security_group" "jenkins-server-sg" {
  name        = "Security group for Jenkins server"
  description = "Jenkins Server Default Security Group"
  vpc_id      = local.vpc_id

  #Allow SSH 
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow port 8080 for Jenkins Server
  ingress {
    description = "Allow Port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow port 80 for Jenkins Server
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic for Jenkins Server
  egress {
    description = "Allow all IP and Ports Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name : "Security group for Jenkins Server"
  }, local.tags)
}
