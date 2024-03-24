resource "aws_instance" "instance1" {
  ami = var.ami
  key_name = var.key_name
  subnet_id = var.subnet
  instance_type=var.instance_type
}
