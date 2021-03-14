output "vpcid" {
  value = module.vpc_module.vpcid
}

output "public_subnets" {
  value = module.subnet_module.public_subnet_id
}
output "private_subnets" {
  value = module.subnet_module.private_subnet_id
}

output "public_ip" {
  value = data.aws_instance.public1.public_ip
}

output "db_ip" {
  value = data.aws_instance.mydb1.private_ip
}


