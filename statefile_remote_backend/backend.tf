terraform {
  backend "s3" {
    bucket = "lekhana-demobucket-123"
    region = "eu-north-1"
    key = "lekhana/terraform.tfstate"
  }
}
