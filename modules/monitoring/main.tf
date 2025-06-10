resource "aws_cloudwatch_log_group" "syslog" {
  name              = "/ec2/syslog"
  retention_in_days = 7
}

