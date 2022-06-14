terraform {
  backend "s3" {
    profile = "master-admin"
    bucket  = "ys-tf-infra"
    key     = "step3/tf-vm"
    region  = "eu-central-1"
  }
}
