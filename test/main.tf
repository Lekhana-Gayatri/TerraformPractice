provider "aws" {
  region = "eu-north-1"
}

module "ec2_instance_create" {
  source = "/workspaces/secondRepo/modules/ec2"
  ami="ami-0d74f1e79c38f2933"
  instance_type="t3.micro"
  key_name="aws-prod-example"
  subnet="subnet-01a3129b94b3cfeba"
}
 output "instance_public_ip" {
  value = module.ec2_instance_create.public_ip
}

output "instance_id" {
  value = module.ec2_instance_create.id
}
