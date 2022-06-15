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

module "vm-alpha-dev" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.alpha-dev
  }
  name = "alpha-dev"
}

module "vm-alpha-stage" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.alpha-stage
  }
  name = "alpha-stage"
}

output "alpha-dev" {
  value = module.vm-alpha-dev.account_id
}

output "alpha-stage" {
  value = module.vm-alpha-stage.account_id
}
