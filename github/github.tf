terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.15.0"
    }
  }
}

provider "github" {
  token = "xxxxxxxx"
}

resource "github_repository" "example" {
  name        = "terraform-course"
  visibility = "private"
}

/*
resource "github_repository" "ansible-aws" {
  name        = "ansible-aws"
  visibility = "public"
}
*/
