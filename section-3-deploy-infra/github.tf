terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.3.2"
    }
  }
}

provider "github" {
  token = "your token here"
}

resource "github_repository" "example" {
  name        = "terraform-repo"

  visibility  = "private"

}