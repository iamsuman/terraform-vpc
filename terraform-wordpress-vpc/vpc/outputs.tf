output "vpcid" {
  description = "VPC id of the main vpc"
  value = aws_vpc.main.id
}

output "igwid" {
  value = aws_internet_gateway.igw.id
}
