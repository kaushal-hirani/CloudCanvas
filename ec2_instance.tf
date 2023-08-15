resource "aws_instance" "web_instance" {
  ami           = data.aws_ami.latest_amazon_ami.id
  instance_type = "t2.micro"
  tags = {
    Name = "WebInstance"
  }
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