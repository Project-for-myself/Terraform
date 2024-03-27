resource "aws_instance" "my_vm" {
  ami           = "ami-023adaba598e661ac" //Ubuntu AMI
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_ports.id]
  subnet_id              = aws_subnet.subnet1.id
  key_name               = "DEVOPS"
  tags = {
    Name     = "Minecraft",
    Provider = "Terraform",
  }
}

resource "aws_vpc" "frankfurt" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name     = "Frankfurt",
    Provider = "Terraform",
  }
}

resource "aws_security_group" "allow_ports" {
  name        = "allow_ports"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.frankfurt.id

  tags = {
    Name = "allow_ports"
  }
}

resource "aws_security_group_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_ports.id
  type              = "ingress"
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ports.id
  type              = "ingress"
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_tls_and_ssh_ipv6" {
  security_group_id = aws_security_group.allow_ports.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  ipv6_cidr_blocks  = ["::/0"]
}


resource "aws_security_group_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_ports.id
  type              = "ingress"
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.allow_ports.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"  # All protocols
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_outbound_ipv6" {
  security_group_id = aws_security_group.allow_ports.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"  # All protocols
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.frankfurt.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a" // Change this to match your desired availability zone
  map_public_ip_on_launch = true
  tags = {
    Name = "My Subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.frankfurt.id
  tags = {
    Name = "My Internet Gateway"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.frankfurt.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.my_route_table.id
}