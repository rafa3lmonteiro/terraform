provider "aws" {
  region = "sa-east-1"
}

resource "aws_key_pair" "key-pub" {
  key_name   = "key-pub"
  public_key = file("./id_rsa.pub")
}

resource "aws_security_group" "allow-ssh-http" {
  ingress {
    description = "SSH Allowed"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP Allowed"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Outbound Allowed"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "test-terraform" {
  ami             = "ami-0054772d386e00cfc"
  instance_type   = "t2.micro"
  key_name        = "key-pub"
  security_groups = ["${aws_security_group.allow-ssh-http.name}"]
  tags = {
    Name = "terraform-course"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1",
      "sudo systemctl start nginx"
    ]
  }

}

output "public-ip" {
  value = aws_instance.test-terraform.public_ip
}

output "public-dns" {
  value = aws_instance.test-terraform.public_dns
}