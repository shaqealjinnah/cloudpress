output "vpc_id" {
  description = "ID of the VPC"
  value = aws_vpc.wordpress_vpc.id
}

output "public_subnet_ids" {
  description = "IDs of public subnet"
  value = aws_subnet.public[*].id
}

output "private_db_subnet_ids" {
  description = "ID of subnet"
  value = aws_subnet.private_db[*].id
}

output "private_app_subnet_ids" {
  description = "ID of subnet"
  value = aws_subnet.private_app[*].id
}