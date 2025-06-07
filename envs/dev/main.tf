module "network" {
  source               = "../../modules/network"
  name                 = "dev"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  azs                  = []
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
  ami_id                = "aws_ami.ubuntu.id"
  instance_type         = "t2.micro"
  security_groups_ids   = [module.security_groups.ec2_sg_id]
  instance_profile_name = module.iam.instance_profile_name
  hostname              = "web-instance"
  project_name          = "myapp"
}
