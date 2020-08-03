module "vpc_module" {
  source = "./vpc"
}
module "subnet_module" {
  source = "./subnet"
  vpcid = module.vpc_module.vpcid
}
module "security_module" {
  source = "./security_group"
  vpcid = module.vpc_module.vpcid
}
module "autoscaling_group" {
  source = "./autoscaling_group"

  ami_id = var.ami_id
  ec2_security_groups = module.security_module.bastion_sg_id
  instance_type = var.instance_type
  key_name = var.key_name
  max_size = var.max_size
  min_size = var.min_size
  root_volume_size = var.root_volume_size
  user_data = var.user_data
  vpc_subnet = module.subnet_module.public_subnets_id
}