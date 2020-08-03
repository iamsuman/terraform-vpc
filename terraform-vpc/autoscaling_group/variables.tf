provider "aws" {
  region = "${var.awsRegion}"
  profile = "${var.aws_profile}"
}

variable "awsRegion" {
  default = "us-west-2"
}

variable "aws_profile" {
  default = "myaws"
}

variable "ami_id" {}
variable "instance_type" {}
variable "root_volume_size" {}
//variable "ebs_volume_size" {}
variable  "key_name" {}

variable "ec2_security_groups" {}
variable "vpc_subnet" {}
variable "min_size" {}
variable "max_size" {}
variable "user_data" {}


variable "private_ec2_security_groups" {}
variable "private_vpc_subnet" {}
variable "private_min_size" {}
variable "private_max_size" {}
variable "private_user_data" {}
