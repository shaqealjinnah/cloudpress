
resource "aws_lb" "alb" {
  name               = "wordpress--alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]          
  subnets            = var.public_subnet_ids    

  enable_deletion_protection = false
  idle_timeout               = 60
  ip_address_type            = "ipv4"


  tags = {
    Name = "wordpress--alb"
  }
}

resource "aws_lb_target_group" "main" {
    name = "wordpress--tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id                         

    health_check {
        path                = "/health.html"
        healthy_threshold   = 2
        unhealthy_threshold = 10
    }

    tags = {
        Name = "wordpress--tg"
    }
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.alb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.main.arn
    }
}

resource "aws_lb_target_group_attachment" "wordpress_instance" {
    count = 2

    target_group_arn = aws_lb_target_group.main.arn
    target_id        = var.wordpress_instance[count.index]
    port             = 80
}