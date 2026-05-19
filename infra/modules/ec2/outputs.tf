output "wordpress_public_ip" {
  description = "Public IP address of the WordPress instances"
  value       = aws_instance.wordpress_instance[*].public_ip
}

output "wordpress_url" {
  description = "URL to access WordPress"
  value       = [
    for instance in aws_instance.wordpress_instance :
    "http://${instance.public_ip}"
  ]
}

output "wordpress_instance" {
  description = "The WordPress Instance"
  value = aws_instance.wordpress_instance[*].id
}