resource "aws_instance" "jenkins_server" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = local.instance_type
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = local.subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins-server-sg.id]


  tags = merge({
    Name = local.name
  }, local.tags)

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = local_sensitive_file.private_key.content
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update",
      "sudo amazon-linux-extras install ansible2 -y",
      "sudo amazon-linux-extras install java-openjdk11 -y",
      "sudo yum install git -y",
      "git clone https://github.com/natan-barel/jenkins_setup_ansible.git /tmp/Jenkins_ansible_role",
      "ansible-playbook /tmp/Jenkins_ansible_role/jenkins_setup_min/install-jenkins.yml",
    ]
  }

}


resource "tls_private_key" "key" {
  algorithm = "RSA"
}
resource "local_sensitive_file" "private_key" {
  filename        = "JENKINS.pem"
  content         = tls_private_key.key.private_key_pem
  file_permission = "0400"
}
resource "aws_key_pair" "key_pair" {
  key_name   = "JENKINS"
  public_key = tls_private_key.key.public_key_openssh
}
