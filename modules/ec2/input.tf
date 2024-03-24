variable "instance_type" {
  type=string
  default = "t3.micro"
}
variable "ami" {
  default = "ami-0914547665e6a707c"
}
variable "key_name" {
  default = "stockholm"
}
variable "subnet" {
  default = "subnet-04ef9db22bea56801"
}
