# AWS Multi-Tier Infrastructure with Terraform

This project sets up a multi-tier AWS infrastructure using Terraform, following best practices for structure, reusability, and version control.

## Structure
- modules/
- envs/
- bin/

## Network structure
it creates a VPC with:
- Public subnets with internet access
- private subnets with NAT-gateway

## Security groups
thie module creates two security groups:
- **alb_sg** 
- **ec2_sg**

## IAM
this module creates:
- an IAM-role
- an instance profile, that launch template would use

## Usage
```bash
terraform init
terraform apply
