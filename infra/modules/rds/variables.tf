variable "db_instance_class" {
  description = "RDS instance class"
  type = string
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

variable "private_subnet_ids" {
  description = "List of IDs for Private Subnets"
  type = list(string)
}

variable "rds_sg_id" {
  description = "ID of RDS Security Group"
  type = string
}