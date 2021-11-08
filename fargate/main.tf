provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "my-klimnyuk-bucket"
    key    = "ecs/fargate"
    region = "eu-central-1"
  }
}

output "load_balancer_link" {
  value = aws_alb.my_ALB.dns_name
}
