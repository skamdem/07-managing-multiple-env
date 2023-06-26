# Networking resources of aws provider

# Load balancer section
data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "set_of_subnet_ids" { # assumed public subnets
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

resource "aws_security_group" "alb_sg" {
  name = "${var.subdomain}-alb-sg"
}

resource "aws_security_group_rule" "alb_ingress_rules" {
  count = length(var.alb_ingress_rules)

  type              = "ingress"
  security_group_id = aws_security_group.alb_sg.id

  from_port   = var.alb_ingress_rules[count.index].from_port
  to_port     = var.alb_ingress_rules[count.index].to_port
  protocol    = var.alb_ingress_rules[count.index].protocol
  cidr_blocks = [var.alb_ingress_rules[count.index].cidr_blocks]
  description = var.alb_ingress_rules[count.index].description
}

resource "aws_security_group_rule" "allow_alb_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.alb_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_lb" "load_balancer" {
  name               = "${var.subdomain}-lb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.set_of_subnet_ids.ids
  security_groups    = [aws_security_group.alb_sg.id]
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Sorry nothing here -:)"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Sorry nothing here -:)"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener_rule" "custom_rule_https" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 50

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_target_group.arn
  }
}

resource "aws_lb_listener_rule" "custom_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 50

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_target_group.arn
  }
}

resource "aws_lb_target_group" "main_target_group" {
  name     = "${var.subdomain}-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200" # response code for healthy responses from a target  
    interval            = 10
    timeout             = 4 # no response -> failed health check
    healthy_threshold   = 2 # consecutive health check successes -> target healthy
    unhealthy_threshold = 2 # consecutive health check failures -> target unhealthy
  }
}

resource "aws_lb_target_group_attachment" "instance_1" {
  target_group_arn = aws_lb_target_group.main_target_group.arn
  target_id        = aws_instance.instance_1.id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "instance_2" {
  target_group_arn = aws_lb_target_group.main_target_group.arn
  target_id        = aws_instance.instance_2.id
  port             = 8080
}


# instances section
# security group for the 2 instances
resource "aws_security_group" "instances_sg" {
  name = "${var.subdomain}-instance-sg"
}

resource "aws_security_group_rule" "allow_instance_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.instances_sg.id
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

