# Create Custom VPC
resource "aws_vpc" "wordpress_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "wordpress--vpc"
    }
}

# Create Public Subnets
resource "aws_subnet" "public" {
    count = 2
    vpc_id = aws_vpc.wordpress_vpc.id
    availability_zone = var.availability_zones[count.index]
    cidr_block = var.public_subnet_cidr[count.index]

    map_public_ip_on_launch = true

    tags = {
        Name = "wordpress--public--subnet-${count.index + 1}"
    }
}

# Create Private Subnets
resource "aws_subnet" "private_db" {
    count = 2
    vpc_id = aws_vpc.wordpress_vpc.id
    availability_zone = var.availability_zones[count.index]
    cidr_block = var.private_db_subnet_cidr[count.index]

    map_public_ip_on_launch = false

    tags = {
        Name = "wordpress--private-db-subnet-${count.index + 1}"
    }
}

resource "aws_subnet" "private_app" {
    count = 2
    vpc_id = aws_vpc.wordpress_vpc.id
    availability_zone = var.availability_zones[count.index]
    cidr_block = var.private_app_subnet_cidr[count.index]

    map_public_ip_on_launch = false

    tags = {
        Name = "wordpress--private-app-subnet-${count.index + 1}"
    }
}

# Attach Internet Gateway
resource "aws_internet_gateway" "wordpress_igw" {
    vpc_id = aws_vpc.wordpress_vpc.id

    tags = {
        Name = "wordpress--internet-gateway"
    }
}

# Create Route Table + Routes
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.wordpress_vpc.id

    tags = {
        Name = "wordpress--public-route-table"
    }
}

resource "aws_route" "internet_access" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
}

resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public)

    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

# Create Private Route Table and Configure Routes
resource "aws_route_table" "private_db" {
    vpc_id = aws_vpc.wordpress_vpc.id

    tags = {
        Name = "wordpress--private-db-route-table"
    }
}

resource "aws_route_table_association" "private_db" {
    count = length(aws_subnet.private_db)

    subnet_id = aws_subnet.private_db[count.index].id
    route_table_id = aws_route_table.private_db.id
}

resource "aws_route_table" "private_app" {
    vpc_id = aws_vpc.wordpress_vpc.id

    tags = {
        Name = "wordpress--private-app-route-table"
    }
}

resource "aws_route_table_association" "private_app" {
    count = length(aws_subnet.private_app)

    subnet_id = aws_subnet.private_app[count.index].id
    route_table_id = aws_route_table.private_app.id
}