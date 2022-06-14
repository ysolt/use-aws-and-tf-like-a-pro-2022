resource "aws_default_subnet" "default_az1" {
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Default subnet for eu-central-1a"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}
locals {
  subnet_id = var.subnet_id != "" ? var.subnet_id : aws_default_subnet.default_az1.id
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.0.0"

  subnet_id = local.subnet_id

  ami = data.aws_ami.amazon_linux.id
  name = var.name
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
