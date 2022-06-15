provider "aws" {
  profile = "org-assumer"
  region = "eu-central-1"

  assume_role {
    role_arn     = "arn:aws:iam::023845671923:role/OrganizationAccountAccessRole"
  }

}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = "shared-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_ram_resource_share" "prod-network" {
  name                      = "shared-vpc"

  tags = {
    Environment = "Production"
  }
}

resource "aws_ram_resource_association" "prod-network" {
 for_each = toset(module.vpc.private_subnet_arns)
  resource_arn       = each.key
  resource_share_arn = aws_ram_resource_share.prod-network.arn
}

resource "aws_ram_principal_association" "prod-network" {
  principal          = "arn:aws:organizations::741723870547:ou/o-pvk5lj0g5f/ou-bm0u-w05ge9u6"
  resource_share_arn = aws_ram_resource_share.prod-network.arn
}

output "shared-vpc-private-subnets" {
  value = module.vpc.private_subnets
}

output "shared-vpc-id" {
  value = module.vpc.vpc_id
}
