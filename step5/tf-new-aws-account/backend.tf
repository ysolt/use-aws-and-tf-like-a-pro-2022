terraform {
  backend "s3" {
    profile = "master-admin"
    bucket  = "ys-tf-infra"
    key     = "step5/new-aws-account"
    region  = "eu-central-1"
  }
}
