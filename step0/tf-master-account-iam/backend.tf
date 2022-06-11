terraform {
  backend "s3" {
    profile = "master-admin"
    bucket  = "ys-tf-infra"
    key     = "step0/tf-bootstrapping"
    region  = "eu-central-1"
  }
}
