resource "aws_instance" "bastion" {
  count                  = var.zones_count
  ami                    = "ami-0a49b025fffbbdac6"
  instance_type          = "t2.micro"
  subnet_id              = element(aws_subnet.public.*.id, count.index)
  key_name               = "test"
  vpc_security_group_ids = [aws_security_group.my_SG.id]
}
