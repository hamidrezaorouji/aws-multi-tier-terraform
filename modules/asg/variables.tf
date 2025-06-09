variable "name" {}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 3
}

variable "desired_capacity" {
  default = 1
}

variable "subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {}
variable "launch_template_id" {}
