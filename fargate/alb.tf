resource "aws_alb" "my_ALB" {
  name            = "my-ALB"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.my_SG.id]
}

resource "aws_alb_listener" "my_loadbalancer_listener" {
  load_balancer_arn = aws_alb.my_ALB.arn
  port              = var.port
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.far.id
    type             = "forward"
  }
}

resource "aws_alb_target_group" "far" {
  name        = "my-target-group"
  port        = var.port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_VPC.id
  target_type = "ip"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
