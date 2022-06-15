terraform {
  backend "s3" {
    profile = "master-admin"
    bucket  = "ys-tf-infra"
    key     = "step1/workload-vm"
    region  = "eu-central-1"
  }
}
