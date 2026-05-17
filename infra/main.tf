module "networking" {
    source = "./modules/networking"

    vpc_cidr = var.vpc_cidr
    aws_region = var.aws_region
    instance_type = var.instance_type
}

module "security" {
    source = "./modules/security"

    admin_ip = var.admin_ip
    vpc_id = module.networking.vpc_id
}

module "ec2" {
    source = "./modules/ec2"

    instance_type = var.instance_type
    vpc_security_group_ids = module.security.vpc_security_group_ids
    subnet_id = module.networking.subnet_id
    key_name = var.key_name
}