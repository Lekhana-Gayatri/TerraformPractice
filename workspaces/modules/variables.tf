variable "ami" {
    description = "ami value"
}   
variable "instance" {
  description = "instanc type"
}
output "public_ip" {
  value=aws_instance.exmple.public_ip
}
