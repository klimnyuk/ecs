variable "zones_count" {
  default = 2
}

variable "port" {
  default = 80
}

variable "fargate_memory" {
  default = 512
}

variable "fargate_cpu" {
  default = 256
}

locals {
  ecr_repository_url = format("%s:%s", "717838986976.dkr.ecr.eu-central-1.amazonaws.com/my-first-image", "nginx")
}
