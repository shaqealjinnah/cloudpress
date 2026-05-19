variable "aws_region" {
    type = string
    description = "AWS Region"
}

variable "vpc_cidr" {
    type = string
    description = "CIDR for VPC"
    default = "10.0.0.0/20"
}

variable "public_subnet_cidr" {
    type = list(string)
    description = "List of CIDR for public subnets"
}

variable "private_subnet_cidr" {
    type = list(string)
    description = "List of CIDR for private subnets"
}

variable "instance_type" {
    type = string
    description = "Type of Instance used"
}

variable "availability_zones" {
    type = list(string)
    description = "List of Availability Zones"
}