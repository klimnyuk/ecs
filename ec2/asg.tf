resource "aws_launch_configuration" "ecs_launch_config" {
  image_id             = "ami-088d915ff2a776984"
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  security_groups      = [aws_security_group.my_SG.id]
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=my-cluster >> /etc/ecs/ecs.config"
  instance_type        = "t2.micro"
  key_name             = "test"
}

resource "aws_autoscaling_group" "my_ASG" {
  name                      = "my_ASG"
  vpc_zone_identifier       = aws_subnet.private.*.id
  launch_configuration      = aws_launch_configuration.ecs_launch_config.name
  target_group_arns         = [aws_alb_target_group.asg.arn]
  desired_capacity          = var.zones_count
  min_size                  = 1
  max_size                  = 10
  health_check_grace_period = 300
  health_check_type         = "ELB"
}
