locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment  = local.account_vars.locals.environment
}

terraform {
  source = "github.com/cloudposse/terraform-aws-ec2-instance?ref=0.40.0"
}

prevent_destroy = true

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../../networking/vpc"
}

inputs = {
  instance_type               = "t2.micro"
  vpc_id                      = "${dependency.vpc.outputs.vpc_id}"
  associate_public_ip_address = true
  name                        = "${locals.environment}-simple-nginx"
  namespace                   = "${locals.environment}-simple-nginx"
  stage                       = "${locals.environment}"
  security_group_rules = [
    {
      type        = "egress"
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow only HTTPS"
    },
  ]

  user_data = "sudo apt update && sudo apt install -y docker.io && sudo docker
  run -d -p 443 toketas/simple-nginx"
}
