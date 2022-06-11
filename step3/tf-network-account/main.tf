provider "aws" {
  profile = "org-admin-machine-user"
  region  = "eu-central-1"
}

resource "aws_organizations_organizational_unit" "workload-accounts" {
  name      = "workload-accounts"
  parent_id = var.parent_id
}

output "workload-ou" {
  value = aws_organizations_organizational_unit.workload-accounts.id
}

resource "aws_organizations_account" "network-account" {
  name  = "ysolt-demo-netacc"
  email = "ysoooolt+network-account@gmail.com"
}

output "network-account" {
  value = aws_organizations_account.network-account.id
}
