# aws EC2 instance 
resource "aws_instance" "lms-api-server" {
  ami                    = "ami-03d0155c1ef44f68a"
  instance_type          = "t2.micro"
  key_name               = "docker2"
  subnet_id              = aws_subnet.lms-subnet1.id
  vpc_security_group_ids = [aws_security_group.lms-web-sg.id]
  user_data              = file("web.sh")
  tags = {
    "Name" = "lms-api-server"
  }

}