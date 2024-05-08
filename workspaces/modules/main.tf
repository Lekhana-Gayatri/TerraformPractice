resource "aws_instance" "exmple" {
  ami=var.ami
  instance_type = var.instance
}
