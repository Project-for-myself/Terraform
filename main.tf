resource "aws_instance" "my_vm" {
  ami           = "ami-023adaba598e661ac" //Ubuntu AMI
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id              = aws_subnet.subnet1.id
  key_name               = "DEVOPS"
  tags = {
    Name     = "LNPP",
    Provider = "Terraform",
  }
}

resource "aws_vpc" "frankfurt" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name     = "Frankfurt",
    Provider = "Terraform",
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.frankfurt.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  type              = "ingress"
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  type              = "ingress"
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.frankfurt.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a" // Change this to match your desired availability zone
}