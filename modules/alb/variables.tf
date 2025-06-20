variable "alb_name" {
  type = string
}

variable "target_group_name" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "vpc_id" {
  type = string
}
