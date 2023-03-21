provider "aws" {
    region = "sa-east-1"
}

resource "aws_instance" "teste-sp" {
  ami = "ami-08f74c738bf3f5a45"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "teste-sp"
  }
}

resource "aws_eip" "lb" {      # 18.228.104.91/32   ok	
  vpc      = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.teste-sp.id      # lb 18.228.104.91/32	 ok
  allocation_id = aws_eip.lb.id
}

resource "aws_security_group" "allow_tls" {
  name        = "rafael-security-group"     # sg-053232fcddcc96900   # lb 18.228.104.91/32	 ok
  vpc_id      = "vpc-06ea1428eb2d7b020"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.lb.public_ip}/32"]    # lb 18.228.104.91/32	 ok
  }

}

