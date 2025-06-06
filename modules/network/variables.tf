variable "name" {}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks fuer private Subnetze"
}
variable "azs" {
  type = list(string)
}
