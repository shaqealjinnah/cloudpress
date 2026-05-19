variable "instance_type" {
    type = string
    description = "The type of Instance you're using"
}

variable "vpc_security_group_ids" {
    type = list(string)
    description = "List of security group IDs"
}

variable "public_subnet_ids" {
    type = list(string)
    description = "IDs of public subnets"
}

variable "key_name" {
    type = string
    description = "EC2 key pair name for SSH access"
}

variable "db_name" {
  description = "The name of the WordPress database"
  type        = string
}

variable "db_username" {
  description = "The username for the WordPress database"
  type        = string
}

variable "db_password" {
  description = "The password for the WordPress database"
  type        = string
  sensitive   = true
}

variable "db_instance" {
    description = "The AWS DB Instance"
    type = object({
        endpoint = string
        port = number
    })

}