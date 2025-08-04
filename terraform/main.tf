provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "demo" {
  bucket = "snyk-demo-poc-bucket-12345"
  acl    = "private"
}
