provider "aws" {
  profile = "org-admin-machine-user"
  region  = "eu-central-1"
}

locals {
  accounts = {
    for x in var.accounts :
    "${x.account_name}" => x
  }
  parent_id = var.parent_id
}

resource "aws_organizations_account" "wl-account" {
  for_each = local.accounts
  name  = each.value.account_name
  email = each.value.email
  parent_id = local.parent_id
}

output "network-accounts" {
  value = aws_organizations_account.wl-account
}
