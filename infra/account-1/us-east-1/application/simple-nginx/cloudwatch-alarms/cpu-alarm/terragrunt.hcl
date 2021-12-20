locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  environment = local.account_vars.locals.environment
  aws_region  = local.region_vars.locals.aws_region
}

terraform {
  source = "github.com/terraform-aws-modules/cloudwatch/aws//modules/metric-alarm?ref=v3.11.0"
}

prevent_destroy = true

include {
  path = find_in_parent_folders()
}

dependency "sns" {
  config_path = "../../sns/slack-alerts"
}

dependency "ec2_instance" {
  config_path = "../../ec2"
}

inputs = {
  alarm_name = "sample-nginx-cpu-alarm"
  alarm_description = "Alert when CPU usage is above 80 percent"
  comparison_operator = "GreaterThanOrEqualThreshold"
  evaluation_periods = 2
  threshold = 80
  period = 120 # seconds
  unit = "Percent"

  namespace = "sample-nginx"
  metric_name = "CPUUtilization"
  statistic = "Average"

  alarm_actions = ["${dependency.sns.slack_topic_arn}"]

  dimensions = {
    InstanceId = "${dependency.ec2_instance.outputs.id}"
  }
}

