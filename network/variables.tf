variable "region" {
  type    = string
  default = "us-east-1"
}
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1c"]
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "cidr_block" {
  type    = string
  default = "172.16.0.0/24"
}
variable "cidr_public_subnets" {
  type    = list(string)
  default = ["172.16.0.0/28", "172.16.0.16/28"]
}
variable "cidr_private_app_subnets" {
  type    = list(string)
  default = ["172.16.0.32/28", "172.16.0.48/28"]
}
variable "cidr_private_db_subnets" {
  type    = list(string)
  default = ["172.16.0.64/28", "172.16.0.80/28"]
}
variable "newbits" {
  type    = number
  default = 4
}
variable "aws_route_create_timeout" {
  type    = string
  default = "2m"
}
variable "aws_route_delete_timeout" {
  type    = string
  default = "5m"
}
