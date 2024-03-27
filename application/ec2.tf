module "network" {
  source = "../networking"
}

resource "aws_instance" "my_vm" {
  ami           = "ami-023adaba598e661ac" //Ubuntu AMI
  instance_type = "t2.micro"

  vpc_security_group_ids = module.network.security_group_ids
  subnet_id              = module.network.subnet_id
  key_name               = "DEVOPS"
  tags = {
    Name     = "Minecraft",
    Provider = "Terraform",
  }
}
