# NACL
resource "aws_network_acl" "lms-nacls" {
  vpc_id = aws_vpc.lms1.id
  tags = {
    "Name" = "lms-nacls"
  }

}