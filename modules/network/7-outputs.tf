output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "aws_security_group_rules_allow_inbound" {
  value = aws_security_group_rule.allow_inbound[*].id
}

output "aws_security_group_rules_allow_outbound" {
  value = aws_security_group_rule.allow_outbound[*].id
}
