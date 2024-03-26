resource "aws_instance" "my_vm1" {
  ami           = "ami-023adaba598e661ac" //Ubuntu AMI
  instance_type = "t2.micro"

  tags = {
    Name     = "My EC2 instance",
    Provider = "Terraform",
  }
}