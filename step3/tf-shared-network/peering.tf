module "vpc_peering_cross_account" {
  source = "git::https://github.com/ysolt/terraform-aws-vpc-peering-multi-account/"

  namespace        = "shared-vpc"
  stage            = "dev"
  name             = "cluster"

  providers = {
    aws.accepter = aws.eu-west-1
    aws.requester = aws
  }

  accepter_enabled = false

  requester_vpc_id                          = module.vpc.vpc_id
  requester_allow_remote_vpc_dns_resolution = true

  accepter_vpc_id                          = module.vpc-eu-west-1.vpc_id
  accepter_allow_remote_vpc_dns_resolution = true
}