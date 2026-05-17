variable "instance_type" {
    type = string
    description = "The type of Instance you're using"
}

variable "vpc_security_group_ids" {
    type = list(string)
    description = "List of security group IDs"
}

variable "subnet_id" {
    type = string
    description = "ID of subnet"
}

variable "key_name" {
    type = string
    description = "EC2 key pair name for SSH access"
}