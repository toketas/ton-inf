locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  environment = local.account_vars.locals.environment
  aws_region  = local.region_vars.locals.aws_region
}

terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v3.11.0"
}

prevent_destroy = true

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "${local.environment}-main"
  cidr = "20.10.0.0/16"

  azs             = ["${local.aws_region}a", "${local.aws_region}b", "${local.aws_region}c"]
  private_subnets = ["20.10.0.0/20", "20.10.16.0/20", "20.10.32.0/20"]
  public_subnets  = ["20.10.128.0/20", "20.10.144.0/20", "20.10.160.0/20"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false
  single_nat_gateway = true
  enable_vpn_gateway = false
}

