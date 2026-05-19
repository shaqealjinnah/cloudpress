# Create Security Groups

## Create Instance Security Group with rules
resource "aws_security_group" "wordpress_security_group" {
    name = "wordpress-security-group"
    description = "Allow HTTP and SSH traffic inbound and all outbound traffic"

    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ec2_from_alb" {
    security_group_id = aws_security_group.wordpress_security_group.id
    description       = "Allow traffic from ALB"

    referenced_security_group_id = aws_security_group.alb_security_group.id
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
    security_group_id = aws_security_group.wordpress_security_group.id
    description = "Allow SSH from admin IP"

    cidr_ipv4 = "${var.admin_ip}/32"
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "all_access" {
    security_group_id = aws_security_group.wordpress_security_group.id

    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

## Create RDS Security Group + Rules
resource "aws_security_group" "rds_security_group" {
    name = "rds-security-group"
    description = "Allow traffic from instances"

    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ec2" {
    security_group_id = aws_security_group.rds_security_group.id
    description       = "Allow inbound from instances"

    referenced_security_group_id = aws_security_group.wordpress_security_group.id
    from_port = 3306
    ip_protocol = "tcp"
    to_port = 3306
}

## Create ALB Security Group + Rules
resource "aws_security_group" "alb_security_group" {
    name = "alb-security-group"
    description = "Security Group for ALB"

    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "http" {
    security_group_id = aws_security_group.alb_security_group.id
    description       = "Allow HTTP inbound from internet"

    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
}

resource "aws_vpc_security_group_egress_rule" "alb_to_ec2" {
    security_group_id = aws_security_group.alb_security_group.id

    referenced_security_group_id = aws_security_group.wordpress_security_group.id
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
}