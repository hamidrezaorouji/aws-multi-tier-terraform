module "network" {
  source               = "../../modules/network"
  name                 = "dev"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
}

module "security_groups" {
  source = "../../modules/security_groups"
  name   = "dev"
  vpc_id = module.network.vpc_id
}

module "iam" {
  source = "../../modules/iam"
}

module "launch_template" {
  source = "../../modules/launch_template"

  name_prefix           = "dev"
  ami_id                = data.aws_ami.ubuntu.id
  instance_type         = "t2.micro"
  security_group_ids   = [module.security_groups.ec2_sg_id]
  instance_profile_name = module.iam.instance_profile_name
  hostname              = "web-instance"
  project_name          = "myapp"
  cloudwatch_config    = data.template_file.cloudwatch_config.rendered
}

module "alb" {
  source = "../../modules/alb"

  alb_name          = "my-alb"
  target_group_name = "my-tg"
  public_subnet_ids = module.network.public_subnet_ids
  security_group_id = module.security_groups.alb_sg_id
  vpc_id            = module.network.vpc_id
}

module "asg" {
  source = "../../modules/asg"

  name               = "web-asg"
  min_size           = 1
  max_size           = 3
  desired_capacity   = 2
  subnet_ids         = module.network.private_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  launch_template_id = module.launch_template.launch_template_id
}

module "sns" {
  source     = "../../modules/sns_topic"
  topic_name = "alarm_topic"
  email      = "test@test.com"
}


module "cpu_alarm" {
  source              = "../../modules/monitoring"
  alarm_name          = "HighCPUAlarm"
  metric_name         = "cpu_usage_user"
  namespace           = "CWAgent"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 3
  threshold           = 80
  comparison_operator = "GreaterThanThreshold"
  description         = "CPU usage > 80% for 3 minutes"
  sns_topic_arn       = module.sns.sns_topic_arn
  dimensions          = { InstanceId = "dummy-instance-id" }
}
