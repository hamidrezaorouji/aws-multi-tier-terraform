resource "aws_cloudwatch_log_group" "syslog" {
  name              = "/ec2/syslog"
  retention_in_days = 7
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_description   = var.description
  actions_enabled     = true
  alarm_actions       = [var.sns_topic_arn]
  dimensions          = var.dimensions
}
