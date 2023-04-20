# vpc
resource "aws_vpc" "lms1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "lms1"
  }
}

# Subnet
resource "aws_subnet" "lms-Subnet1" {
  vpc_id                  = aws_vpc.lms1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "lms-Subnet1"
  }
}
