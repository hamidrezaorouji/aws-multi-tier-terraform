resource "aws_sns_topic" "topic" {
  name = var.topic_name
}

resource "aws_sns_topic_policy" "allow_cloudwatch" {
  arn    = aws_sns_topic.topic.arn
  policy = data.aws_iam_policy_document.cloudwatch_publish.json
}

data "aws_iam_policy_document" "cloudwatch_publish" {
  statement {
    sid    = "AllowCloudWatchToPublish"
    effect = "Allow"

  principals {
    type        = "Service"
    identifiers = ["cloudwatch.amazonaws.com"]
  }

  actions   = ["sns:Publish"]
  resources = ["aws_sns_topic.topic.arn"]
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = var.email
}
