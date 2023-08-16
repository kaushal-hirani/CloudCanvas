resource "aws_instance" "web_instance" {
  ami           = data.aws_ami.latest_amazon_ami.id
  instance_type = "t2.micro"
  tags = {
    Name = "WebInstance"
  }
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  iam_instance_profile = aws_iam_instance_profile.web_instance_profile.name
  key_name             = aws_key_pair.web-ssh.key_name
  user_data            = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "Hello, World!" > /var/www/html/index.html
    EOF
}

resource "aws_key_pair" "web-ssh" {
  key_name   = "web-ssh"
  public_key = var.public_key
}

data "aws_ami" "latest_amazon_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}
