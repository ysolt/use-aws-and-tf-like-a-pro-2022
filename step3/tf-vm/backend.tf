terraform {
  backend "s3" {
    profile = "master-admin"
    bucket  = "ys-tf-infra"
    key     = "step3/tf-vm-shared-vpc"
    region  = "eu-central-1"
  }
}
