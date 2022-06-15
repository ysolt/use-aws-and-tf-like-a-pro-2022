provider "aws" {
  profile = "alpha-dev-sso"
  alias   = "alpha-dev"
  region  = "eu-central-1"
}

provider "aws" {
  profile = "alpha-stage-sso"
  alias   = "alpha-stage"
  region  = "eu-central-1"
}

module "vm-alpha-dev" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.alpha-dev
  }
  name = "alpha-dev-step6"
}

module "vm-alpha-stage" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.alpha-stage
  }
  name = "alpha-stage-step6"
}

output "alpha-dev" {
  value = module.vm-alpha-dev.account_id
}

output "alpha-stage" {
  value = module.vm-alpha-stage.account_id
}
