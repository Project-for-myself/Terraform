output "subnet_id" {
  value = aws_subnet.subnet1.id
}

output "security_group_ids" {
  value = [aws_security_group.allow_ports.id]
}