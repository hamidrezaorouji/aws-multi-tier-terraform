variable "name_prefix" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "instance_profile_name" {
  type = string
}

variable "hostname" {
  type = string
}

variable "project_name" {
  type = string
}

