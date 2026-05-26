# RDS Subnet Group
resource "aws_db_subnet_group" "wordpress" {
  name       = "wordpress-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name = "WordPress DB subnet group"
  }
}

# RDS Instance
resource "aws_db_instance" "wordpress" {
  identifier           = "wordpress-db"
  allocated_storage    = 20
  storage_type        = "gp2"
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = var.db_instance_class
  db_name             = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true

  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name   = aws_db_subnet_group.wordpress.name
}