
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

module "workload_ssh_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["10.10.0.0/16"]
  ingress_rules       = ["https-443-tcp"]
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
  vpc_security_group_ids = [module.workload_ssh_security_group.security_group_id]
}