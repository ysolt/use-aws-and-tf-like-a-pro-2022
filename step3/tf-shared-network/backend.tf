terraform {
  backend "s3" {
    profile = "master-admin"
    bucket  = "ys-tf-infra"
    key     = "step3/tf-shared-network"
    region  = "eu-central-1"
  }
}
