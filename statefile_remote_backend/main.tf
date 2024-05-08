provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "instance1" {
  ami = "ami-0914547665e6a707c"
  instance_type = "t3.micro"
  subnet_id = "subnet-04ef9db22bea56801"
  key_name = "aws-prod-example"

}
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "lekhana-demobucket-123"
}
resource "aws_s3_bucket" "example" {
  bucket = "lekhana-demobuck-1234"
  
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Suspended"
  }
}
