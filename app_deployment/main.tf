provider "aws"{
    region = "eu-north-1"
}

variable "cidr" {
  default="10.0.0.0/16"
}

resource "aws_key_pair" "name" {
  key_name = "aws-prod-example"
  public_key = file("~/.ssh/id_rsa.pub")
}
resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}
resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw"{
    vpc_id=aws_vpc.myvpc.id
}
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.sub1.id 
    route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "websg" {
    name="web"
    vpc_id=aws_vpc.myvpc.id
    ingress{
        from_port = 80
        to_port = 80
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port = 22
        to_port = 22
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      name="web-sg"
    }
}

resource "aws_instance" "server" {
  ami = "ami-0914547665e6a707c"
  instance_type = "t3.micro"
  key_name = aws_key_pair.name.key_name
  vpc_security_group_ids = [aws_security_group.websg.id]
  subnet_id = aws_subnet.sub1.id

  connection {
    type="ssh"
    user="ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host = self.public_ip
  }
  provisioner "file" {
    source = "a.py"
    destination = "/home/ubuntu/a.py"

  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo su",
      "echo 'hello from the remote instance'",
      "apt update -y",
      "echo 'installing pip'",
      "apt install -y python3-pip",
      "apt install python3-venv",
      "echo 'cd to Fundraising'",
      "cd /home/ubuntu/Fundraising",
      "echo 'installing venev'",
      "python3 -m venv env",
      "echo 'activating env'",
      "./env/Scripts/activate",
      "echo 'installing django'",
      "pip3 install django",
      "echo 'cd to myproject'",
      "cd myproject",
      "echo 'running server'",
      "python3 a.py"
     ]
  }
}
  
output "public_ip" {
  value = aws_instance.server.public_ip
}
