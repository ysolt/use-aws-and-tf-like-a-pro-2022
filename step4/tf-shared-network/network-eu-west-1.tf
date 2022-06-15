provider "aws" {
  profile = "org-assumer"
  region = "eu-west-1"
  alias = "eu-west-1"

  assume_role {
    role_arn     = "arn:aws:iam::023845671923:role/OrganizationAccountAccessRole"
  }

}

module "vpc-eu-west-1" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  providers = {
    aws = aws.eu-west-1
  }

  name = "shared-vpc"
  cidr = "10.1.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

  enable_nat_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
