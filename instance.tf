resource "aws_instance" "server" {
  ami = var.ami
  instance_type = var.type
  key_name = var.key
  tags = {
     Name = var.name
  }
}