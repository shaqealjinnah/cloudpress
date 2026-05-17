output "vpc_id" {
  description = "ID of the VPC"
  value = aws_vpc.wordpress_vpc.id
}

output "subnet_id" {
  description = "ID of subnet"
  value = aws_subnet.wordpress_public_subnet_1.id
}