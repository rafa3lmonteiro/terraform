provider "aws" {
    region = "sa-east-1"
}


resource "aws_instance" "teste-sp" {
  ami = "ami-08f74c738bf3f5a45"
  instance_type = "t2.micro"

  tags = {
    Name = "teste-sp"
  }
}

output "ec2-instance" {
  value = aws_instance.teste-sp.public_ip
}

/*
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa your key lab-ec2"
}
*/

