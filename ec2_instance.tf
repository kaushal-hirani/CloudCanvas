resource "aws_instance" "web_instance" {
  ami           = data.aws_ami.latest_amazon_ami.id
  instance_type = "t2.micro"
  tags = {
    Name = "WebInstance"
  }
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  iam_instance_profile = aws_iam_instance_profile.web_instance_profile.name
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