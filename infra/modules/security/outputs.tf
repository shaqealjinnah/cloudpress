output "vpc_security_group_ids" {
    description = "Array of security group IDs"
    value = [aws_security_group.wordpress_security_group.id]
}