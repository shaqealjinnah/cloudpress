output "vpc_security_group_ids" {
    description = "Array of security group IDs"
    value = [aws_security_group.wordpress_security_group.id]
}

output "rds_sg_id" {
    description = "ID of RDS Security Group"
    value = aws_security_group.rds_security_group.id
}

output "alb_sg_id" {
    description = "ID of ALB Security Group"
    value = aws_security_group.alb_security_group.id
}