output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.example.id
}

output "instance_public_ip" {
  value = aws_instance.server.public_ip
}