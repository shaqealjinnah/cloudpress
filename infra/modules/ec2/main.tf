# Create EC2 Instance bootstrapped with WordPress
data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }

}

data "template_file" "user_data" {
    template = file("${path.module}/../../../scripts/install_wordpress.sh")

    vars = {
        db_name     = var.db_name
        db_username = var.db_username
        db_password = var.db_password
        db_endpoint = replace(var.db_instance.endpoint, ":3306", "")
    }
}

resource "aws_instance" "wordpress_instance" {
    count = 2
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    associate_public_ip_address = true
    subnet_id = var.private_app_subnet_ids[count.index]
    vpc_security_group_ids = var.vpc_security_group_ids

    key_name = var.key_name
    user_data = data.template_file.user_data.rendered

    tags = {
        Name = "wordpress--instance-${count.index + 1}"
    }

    depends_on = [var.db_instance]

}