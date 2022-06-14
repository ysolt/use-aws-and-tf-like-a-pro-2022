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

module "vm-alpha" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.alpha
  }
  name = "alpha"
}

module "vm-bravo" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.bravo
  }
  name = "bravo"
}

output "alpha" {
  value = module.vm-alpha.account_id
}

output "bravo" {
  value = module.vm-bravo.account_id
}
