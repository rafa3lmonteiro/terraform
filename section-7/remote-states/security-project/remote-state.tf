data "terraform_remote_state" "eip" {
  backend = "s3"

  config = {
    bucket = "rafael-terraform-backend"
    key    = "network/eip.tfstate"
    region = "sa-east-1"
    }
  }
