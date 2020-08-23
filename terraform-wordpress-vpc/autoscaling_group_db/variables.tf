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
variable "ebs_volume_size" {}
variable  "key_name" {}

variable "private_ec2_security_groups" {}
variable "private_vpc_subnet" {}
variable "private_min_size" {}
variable "private_max_size" {}
variable "private_user_data" {}

//variable "DB_NAME" {}
//variable "USER_NAME" {}
//variable "DB_PASS" {}
//variable "DB_HOST" {}
