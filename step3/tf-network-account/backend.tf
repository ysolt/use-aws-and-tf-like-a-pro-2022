terraform {
  backend "s3" {
    profile = "master-admin"
    bucket  = "ys-tf-infra"
    key     = "step3/tf-network-account"
    region  = "eu-central-1"
  }
}
