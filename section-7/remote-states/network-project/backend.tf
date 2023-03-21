terraform {
  backend "s3" {
    bucket = "rafael-terraform-backend"
    key    = "network/eip.tfstate"
    region = "sa-east-1"
  }
}
