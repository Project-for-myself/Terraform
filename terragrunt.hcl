remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "devops.terraform.backend.state"
    key    = "${path_relative_to_include()}/terraform.tfstate"
    region = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}