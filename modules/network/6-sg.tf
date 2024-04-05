resource "aws_security_group" "this" {
  name        = "this"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${var.env}-main"
  }
}

resource "aws_security_group_rule" "allow_inbound" {
  count = length(var.security_group_inbound_rules)

  security_group_id = aws_security_group.this.id
  type              = "ingress"
  from_port         = var.security_group_inbound_rules[count.index]
  protocol          = "tcp"
  to_port           = var.security_group_inbound_rules[count.index]
  cidr_blocks       = var.sg_cidr_block
}

resource "aws_security_group_rule" "allow_outbound" {
  count = length(var.security_group_outbound_rules)

  security_group_id = aws_security_group.this.id
  type              = "egress"
  from_port         = var.security_group_outbound_rules[count.index]
  to_port           = var.security_group_outbound_rules[count.index]
  protocol          = "-1" # All protocols
  cidr_blocks       = var.sg_cidr_block
}
