locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  environment  = local.account_vars.locals.environment
  aws_region   = local.region_vars.locals.aws_region
}

terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-notify-slack?ref=v4.24.0"
}

prevent_destroy = true

include {
  path = find_in_parent_folders()
}

inputs = {
  sns_topic_name = "sample-nginx-monitoring-topic"

  slack_webhook_url = "<slack_url>"
  slack_channel     = "<channel_name>"
  slack_username    = "<bot_name>"
}
