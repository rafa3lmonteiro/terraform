provider "aws" {
    region = "sa-east-1"
}

locals {
  common_tags = {
    Owner = "DevOps Team"
    service = "backend"
  }
}

resource "aws_instance" "app-dev" {
  ami = "ami-08f74c738bf3f5a45"
  instance_type = "t2.micro"
  tags = local.common_tags
}

resource "aws_instance" "db-dev" {
  ami = "ami-08f74c738bf3f5a45"
  instance_type = "t2.small"
  tags = local.common_tags
}

resource "aws_ebs_volume" "db_ebs" {
  availability_zone = "sa-east-1"
  size              = 8
  tags = local.common_tags
}

# Valores locais podem ser usados para multiplos diferentes casos de usos e podem ter condicionais
#
#locals {
#  name_prefix = "${var.name != "" ? var.name : var.default}"
#}      

