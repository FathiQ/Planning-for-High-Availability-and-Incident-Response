resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  vpc_id      = var.vpc_id

  ingress {    
    description = "web port"
    from_port   = 80    
    to_port     = 80
    protocol    = "tcp"    
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg"
  }
}

data "aws_instances" "ubuntu" {
  instance_tags = {
    Name = "Ubuntu-Web"
  }

  filter {
    name   = "instance.group-id"
    values = [output.ec2_sg]
  }

  instance_state_names = ["running"]
}

resource "aws_lb" "project_ec2_alb" {
  name               = "project-ec2-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false


  tags = {
    Environment = "production"
  }

  # depends_on = [
  
  # ]
}

resource "aws_lb_listener" "project_ec2_alb_lsn" {
  load_balancer_arn = aws_lb.project_ec2_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project_ec2_alb_tg.arn
  }
  depends_on = [
    aws_lb.project_ec2_alb,
    aws_lb_target_group.project_ec2_alb_tg
  ]
}

resource "aws_lb_target_group" "project_ec2_alb_tg" {
  name     = "project-ec2-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id


  health_check {
    path                = "/metrics"
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-499"
  }
}

resource "aws_lb_target_group_attachment" "project_ec2_tg_attach_1" {
  target_group_arn = aws_lb_target_group.project_ec2_alb_tg.arn
  target_id        = data.aws_instances.ubuntu.ids[0]
  port             = 80

  depends_on = [
    data.aws_instances.ubuntu,
    aws_lb.project_ec2_alb,
  ]
}

resource "aws_lb_target_group_attachment" "project_ec2_tg_attach_2" {
  target_group_arn = aws_lb_target_group.project_ec2_alb_tg.arn
  target_id        = data.aws_instances.ubuntu.ids[1]
  port             = 80
  depends_on = [
    data.aws_instances.ubuntu,
    aws_lb.project_ec2_alb
  ]
}

resource "aws_lb_target_group_attachment" "project_ec2_tg_attach_3" {
  target_group_arn = aws_lb_target_group.project_ec2_alb_tg.arn
  target_id        = data.aws_instances.ubuntu.ids[2]
  port             = 80
  depends_on = [
    data.aws_instances.ubuntu,
    aws_lb.project_ec2_alb
  ]
}