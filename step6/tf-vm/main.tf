provider "aws" {
  profile = "alpha-sso"
  alias   = "alpha"
  region  = "eu-central-1"
}

provider "aws" {
  profile = "bravo-sso"
  alias   = "bravo"
  region  = "eu-central-1"
}

module "vm-alpha" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.alpha
  }
  name = "alpha-step6"
}

module "vm-bravo" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.bravo
  }
  name = "bravo-step6"
}

output "alpha" {
  value = module.vm-alpha.account_id
}

output "bravo" {
  value = module.vm-bravo.account_id
}
