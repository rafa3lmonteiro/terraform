provider "aws" {
  region     = "ap-southeast-1"
}

resource "aws_eip" "lb" {
  vpc      = true
  count = 0
}


resource "null_resource" "ip_check" {

 triggers = {
    latest_ips = join(",", aws_eip.lb[*].public_ip)
  }

 provisioner "local-exec" {

   command = "echo Latest IPs are ${null_resource.ip_check.triggers.latest_ips} > sample.txt"

  }
}