resource "aws_instance" "amazon-linux2" {
   ami = "ami-0054772d386e00cfc"
   instance_type = var.instance_type
}