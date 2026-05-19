variable "public_subnet_ids" {
    description = "IDs of public subnets"
    type = list(string)
}

variable "vpc_id" {
    description = "ID of VPC"
    type = string
}

variable "alb_sg_id" {
    description = "ID of ALB Security Group"
    type = string
}

variable "wordpress_instance" {
    description = "The WordPress Instance"
    type = list(string)
}