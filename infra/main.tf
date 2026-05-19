module "networking" {
  source = "./modules/networking"

  vpc_cidr      = var.vpc_cidr
  aws_region    = var.aws_region
  instance_type = var.instance_type
  availability_zones = var.availability_zones
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "security" {
  source = "./modules/security"

  admin_ip = var.admin_ip
  vpc_id   = module.networking.vpc_id
}

module "ec2" {
  source = "./modules/ec2"

  instance_type          = var.instance_type
  vpc_security_group_ids = module.security.vpc_security_group_ids
  public_subnet_ids      = module.networking.public_subnet_ids
  key_name               = var.key_name
  db_name                = var.db_name
  db_username                = var.db_username
  db_password                = var.db_password
  db_instance            = module.rds.db_instance
}

module "rds" {
  source = "./modules/rds"

  db_instance_class = var.db_instance_class
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  private_subnet_ids = module.networking.private_subnet_ids
  rds_sg_id         = module.security.rds_sg_id
}

module "alb" {
  source = "./modules/alb"

  public_subnet_ids = module.networking.public_subnet_ids
  vpc_id   = module.networking.vpc_id
  alb_sg_id = module.security.alb_sg_id
  wordpress_instance = module.ec2.wordpress_instance
}