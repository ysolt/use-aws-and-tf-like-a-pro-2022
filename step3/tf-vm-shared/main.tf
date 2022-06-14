provider "aws" {
  profile = "alpha"
  alias   = "alpha"
  region  = "eu-central-1"
}

provider "aws" {
  profile = "bravo"
  alias   = "bravo"
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

module "vm-alpha" {
  source = "../../modules/vm-module-with-sg"
  providers = {
    aws = aws.alpha
  }
  name = "alpha-shared-vpc"
  subnet_id = data.terraform_remote_state.network.outputs.shared-vpc-private-subnets[0]
  vpc_id = data.terraform_remote_state.network.outputs.shared-vpc-id
}

module "vm-bravo" {
  source = "../../modules/vm-module-with-sg"
  providers = {
    aws = aws.bravo
  }
  name = "bravo-shared-vpc"
  subnet_id = data.terraform_remote_state.network.outputs.shared-vpc-private-subnets[0]
  vpc_id = data.terraform_remote_state.network.outputs.shared-vpc-id
}