provider "aws" {
  profile = "org-admin-machine-user"
  region  = "eu-central-1"
}

locals {
  accounts = {
    for x in var.accounts :
    "${x.account_name}" => x
  }
  parent_id = data.terraform_remote_state.network.outputs.workload-ou
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    profile = "master-admin"
    bucket  = "ys-tf-infra"
    key     = "step3/tf-network-account"
    region  = "eu-central-1"
  }
}

resource "aws_organizations_account" "account" {
  for_each = local.accounts
  name  = each.value.account_name
  email = each.value.email
  parent_id = local.parent_id
}
