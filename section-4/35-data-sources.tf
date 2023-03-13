provider "aws" {
  region     = "sa-east-1"
}


data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_key_pair" "loginkey" {
  key_name   = "login-key"
  public_key = file("${path.module}/id_rsa.pub")
}


resource "aws_instance" "linux-1" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.loginkey.key_name
  tags = {
    Name = "linux-1"
  }
}


output "ec2-instance" {
  value = data.aws_ami.app_ami.id
}
output "ec2-instance2" {
  value = aws_instance.linux-1.public_ip
}
