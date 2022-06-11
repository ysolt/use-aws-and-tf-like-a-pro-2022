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

module "vm-wl1" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.wl1
  }
  name = "wl1"
}

module "vm-wl2" {
  source = "../../modules/vm-module"
  providers = {
    aws = aws.wl2
  }
  name = "wl2"
}