module "networking" {
    source = "./modules/networking"

    vpc_cidr = var.vpc_cidr
    aws_region = var.aws_region
    instance_type = var.instance_type
    key_name = var.key_name
}

module "security" {
    source = "./modules/security"

    admin_ip = var.admin_ip
}