provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "myec2" {
  ami = "ami-04473c3d3be6a927f"
  instance_type = lookup(var.instance_type, terraform.workspace)
}

variable "instance_type" {
    type = map(string)
    
    default = {
        default = "t2.nano"
        dev     = "t1.micro"
        prd     = "t2.micro"
    }
}