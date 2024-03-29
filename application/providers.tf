provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "devops.terraform.backend.state"
    key    = "application.tf"
    region = "eu-central-1"
  }
}