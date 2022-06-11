terraform {
  backend "s3" {
    profile = "master-admin"
    bucket  = "ys-tf-infra"
    key     = "step0/tf-workload-accounts"
    region  = "eu-central-1"
  }
}
