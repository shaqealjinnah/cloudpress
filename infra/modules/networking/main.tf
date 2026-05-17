# Create Custom VPC
resource "aws_vpc" "wordpress_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    

    tags = {
        Name = "wordpress-vpc"
    }
}

# Create Subnet
resource "aws_subnet" "wordpress_public_subnet_1" {
    vpc_id = aws_vpc.wordpress_vpc.id
    availability_zone = "${var.aws_region}a"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true

    tags = {
        Name = "wordpress-public-subnet-1"
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "wordpress_igw" {
    vpc_id = aws_vpc.wordpress_vpc.id

    tags = {
        Name = "wordpress-internet-gateway"
    }
}

# Create Route Table + Routes
resource "aws_route_table" "wordpress_route_table" {
    vpc_id = aws_vpc.wordpress_vpc.id

    tags = {
        Name = "wordpress-route-table"
    }
}

resource "aws_route" "wordpress_internet_access" {
    route_table_id = aws_route_table.wordpress_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
}

resource "aws_route_table_association" "wordpress_subnet_association" {
    subnet_id = aws_subnet.wordpress_public_subnet_1.id
    route_table_id = aws_route_table.wordpress_route_table.id
}