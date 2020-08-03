output "vpcid" {
  value = module.vpc_module.vpcid
}

output "public_subnets" {
  value = module.subnet_module.public_subnets_id
}
output "private_subnets" {
  value = module.subnet_module.private_subnets_id
}


