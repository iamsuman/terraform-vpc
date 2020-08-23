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
module "route53" {
  source = "./route53"
  igwid = module.vpc_module.igwid
  public_subnet_id = module.subnet_module.public_subnet_id
  private_subnet_id = module.subnet_module.private_subnet_id
  vpcid = module.vpc_module.vpcid
}
module "autoscaling_group_web" {
  source = "autoscaling_group_web"
  ami_id = var.ami_id
  ec2_security_groups = module.security_module.public_sg_id
  instance_type = var.instance_type
  ebs_volume_size = var.ebs_volume_size
  key_name = var.key_name
  public_max_size = var.public_max_size
  public_min_size = var.public_min_size
  root_volume_size = var.root_volume_size
  user_data = data.template_file.public-bootstrap-template.rendered
  vpc_subnet = [module.subnet_module.public_subnet_id]
}

module "autoscaling_group_db" {
  source = "autoscaling_group_db"
  ami_id = var.ami_id
  instance_type = var.instance_type
  ebs_volume_size = var.ebs_volume_size
  key_name = var.key_name
  root_volume_size = var.root_volume_size
  private_ec2_security_groups = module.security_module.private_sg_id
  private_max_size = var.private_max_size
  private_min_size = var.private_min_size
  private_user_data = data.template_file.private-bootstrap-template.rendered
  private_vpc_subnet = module.subnet_module.private_subnet_id
}