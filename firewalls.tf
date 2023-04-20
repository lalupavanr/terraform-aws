# NACL
resource "aws_network_acl" "lms-nacls" {
  vpc_id = aws_vpc.lms1.id
  tags = {
    "Name" = "lms-nacls"
  }

}

# Add Inbound Rules 
resource "aws_network_acl_rule" "lms-inbound-nacl-rule" {
  network_acl_id = aws_network_acl.lms-nacls.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535

}

# Add Outbound Rules
resource "aws_network_acl_rule" "lms-outbound-nacl-rule" {
  network_acl_id = aws_network_acl.lms-nacls.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535

}

# Nacl - subnet - association
resource "aws_network_acl_association" "lms-subnet" {
  network_acl_id = aws_network_acl.lms-nacls.id
  subnet_id      = aws_subnet.lms-subnet1.id

}

# Security Group
resource "aws_security_group" "lms-web-sg" {
  name        = "allow ssh-http"
  description = "allow ssh & http traffic"
  vpc_id      = aws_vpc.lms1.id
  tags = {
    "Name" = "lms-web-sg"
  }

}

# Add Security group inbound rules
resource "aws_security_group_rule" "lms-ssh-rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lms-web-sg.id


}

resource "aws_security_group_rule" "lms-http-rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lms-web-sg.id


}

# Add security group outbound rules
resource "aws_security_group_rule" "lms-outbound-rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lms-web-sg.id


}