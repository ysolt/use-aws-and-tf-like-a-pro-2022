provider "aws" {
  profile = "master-admin"
  region  = "eu-central-1"
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "ys-tf-infra"
  acl    = "private"

  versioning = {
    enabled = true
  }

}