terraform {
  backend "s3" {
    bucket = "rafael-terraform-backend"
    key    = "network/demo.tfstate"
    region = "sa-east-1"
    dynamodb_table = "terraform-state-locking"
  }
}


resource "time_sleep" "wait_150_seconds" {

  create_duration = "150s"
}