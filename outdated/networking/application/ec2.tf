data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "devops.terraform.backend.state"
    key    = "networking/terraform.tfstate"
    region = "eu-central-1"
  }
}

resource "aws_instance" "my_vm" {
  ami           = "ami-023adaba598e661ac" //Ubuntu AMI
  instance_type = "t2.micro"

  vpc_security_group_ids = [data.terraform_remote_state.networking.outputs.security_group_ids]
  subnet_id              = data.terraform_remote_state.networking.outputs.subnet_id
  key_name               = "DEVOPS"
  tags = {
    Name     = "Minecraft",
    Provider = "Terraform",
  }
}
