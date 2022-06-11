provider "aws" {
  profile = "wl1"
  alias   = "wl1"
  region  = "eu-central-1"
}

provider "aws" {
  profile = "wl2"
  alias   = "wl2"
  region  = "eu-central-1"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    profile = "master-admin"
    bucket  = "ys-tf-infra"
    key     = "step3/tf-shared-network"
    region  = "eu-central-1"
  }
}

module "vm-wl1" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.wl1
  }
  name = "wl1-shared-vpc"
  subnet_id = data.terraform_remote_state.network.outputs.shared-vpc-private-subnets[0]
#  vpc_id = data.terraform_remote_state.network.outputs.shared-vpc-id
}

module "vm-wl2" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.wl2
  }
  name = "wl2-shared-vpc"
  subnet_id = data.terraform_remote_state.network.outputs.shared-vpc-private-subnets[0]
#  vpc_id = data.terraform_remote_state.network.outputs.shared-vpc-id
}