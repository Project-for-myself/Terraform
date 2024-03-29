resource "aws_s3_bucket" "terraform" {
  bucket = "devops.terraform.backend.state"

  tags = {
    Name        = "devops.terraform.backend.state"
    Environment = "prod"
  }
}