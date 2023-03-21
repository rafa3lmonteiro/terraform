# Example of a Map variable:

variable "vpc_cidr_block" {
  type = map
  default = {
    us-east-1 = "192.168.10.0/24"
    ap-south-1 = "192.168.20.0/24"
    us-west-2  = "10.77.0.0/16"
  }
}
