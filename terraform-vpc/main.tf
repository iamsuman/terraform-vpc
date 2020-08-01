module "vpc_module" {
  source = "./vpc"
}
module "subnet_module" {
  source = "./subnet"
  vpcid = module.vpc_module.vpcid
}