provider "aws" {
  profile = "alpha-dev"
  alias   = "alpha-dev"
  region  = "eu-central-1"
}

provider "aws" {
  profile = "alpha-stage"
  alias   = "alpha-stage"
  region  = "eu-central-1"
}

module "vm-alpha-dev" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.alpha-dev
  }
  name = "alpha-dev-step2"
}

module "vm-alpha-stage" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.alpha-stage
  }
  name = "alpha-stage-step2"
}

output "alpha-dev" {
  value = module.vm-alpha-dev.account_id
}

output "alpha-stage" {
  value = module.vm-alpha-stage.account_id
}
