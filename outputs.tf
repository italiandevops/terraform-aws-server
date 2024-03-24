###################################################
# VPC
###################################################

# export the region
output "region" {
  value = var.region
}

# export the vpc id
output "vpc_id" {
  value = aws_vpc.web_vpc.id
}

# export the internet gateway
output "internet_gateway" {
  value = aws_internet_gateway.web_internet_gateway.id
}

# export the public subnet az1 id
output "public_subnet_az1_id" {
  value = aws_subnet.web_public_subnet_az1.id
}

# export the first availability zone
output "availability_zone_1" {
  value = data.aws_availability_zones.available_zones.names[0]
}

###################################################
# SECURITY GROUPS
###################################################

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.web_sg.id
}

###################################################
# INSTANCE
###################################################

output "instance_public_ip" {
  value = aws_instance.server.public_ip
}