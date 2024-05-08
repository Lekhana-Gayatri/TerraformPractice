provider "aws" {
  region = "eu-north-1"
}

variable "ami" {
    description = "ami value"
}   

variable "instance" {
  description = "instanc type"
  type = map(string)
  default = {
    "dev"="t3.nano"
    "prod"="t3.micro"
    "stage"="t3.small"
  }
}

module "ec2_create_instance" {
  source = "/workspaces/secondRepo/workspaces/modules/ec2_instance"
  ami=var.ami
  instance=lookup(var.instance,terraform.workspace,"t3.micro")
}
