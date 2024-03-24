###################################################
# VPC 
###################################################

resource "aws_vpc" "web_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "web-vpc"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "web_internet_gateway" {
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name = "web-igw"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

# create public subnet az1
resource "aws_subnet" "web_public_subnet_az1" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "web-public-az1"
  }
}

# create route table and add public route
resource "aws_route_table" "web_public_route_table" {
  vpc_id = aws_vpc.web_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_internet_gateway.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.web_internet_gateway.id
  }

  tags = {
    Name = "web-public-rt"
  }
}

# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "web_public_subnet_az1_rt_association" {
  subnet_id      = aws_subnet.web_public_subnet_az1.id
  route_table_id = aws_route_table.web_public_route_table.id
}

###################################################
# SECURITY GROUP
###################################################

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Web security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["XXX/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_sg"
  }
}

###################################################
# INSTANCE
###################################################

resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = var.type
  key_name      = var.key
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = var.name
  }
}