# vpc
resource "aws_vpc" "lms1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "lms1"
  }
}

# Subnet
resource "aws_subnet" "lms-subnet1" {
  vpc_id                  = aws_vpc.lms1.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "lms-subnet1"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "lms-igw" {
  vpc_id = aws_vpc.lms1.id

  tags = {
    Name = "lms-igw"
  }
}

# Route table

resource "aws_route_table" "lms-rt" {
  vpc_id = aws_vpc.lms1.id
  tags = {
    Name = "lms-rt"
  }
}
