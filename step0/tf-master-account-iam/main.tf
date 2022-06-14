provider "aws" {
  profile = "master-admin"
  region  = "eu-central-1"
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "ys-tf-infra"
  acl    = "private"

  versioning = {
    enabled = true
  }
}

provider "aws" {
  profile = "org-assumer"
  region = "eu-central-1"
  alias = "wl1"

  assume_role {
    role_arn     = "arn:aws:iam::234539872435:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  profile = "org-assumer"
  region = "eu-central-1"
  alias = "wl2"

  assume_role {
    role_arn     = "arn:aws:iam::957694108706:role/OrganizationAccountAccessRole"
  }
}

module "iam_user_wl1" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  providers = {
    aws = aws.wl1
  }

  name          = "workload-admin"
}

module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  providers = {
    aws = aws.wl2
  }

  name          = "workload-admin"
  force_destroy = true
}

output "pgp_key" {
  value = module.iam_user
  sensitive = true
}