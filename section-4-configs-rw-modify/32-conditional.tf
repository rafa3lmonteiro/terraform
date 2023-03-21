provider "aws" {
    region = "sa-east-1"
}

variable "test" {}

resource "aws_instance" "dev" {
  ami = "ami-08f74c738bf3f5a45"
  instance_type = "t2.micro"
  count = var.test == true ? 1 : 0    # se o meu vat.test for verdadeiro, cria o recurso contando 1, senão 0
}

resource "aws_instance" "prod" {
  ami = "ami-08f74c738bf3f5a45"
  instance_type = "t2.large"
  count = var.test == false ? 1 : 0    # se o meu vat.test for falso, cria o recurso contando 1, senão 0
}