output "vpcid" {
  description = "VPC id of the main vpc"
  value = "${aws_vpc.main.id}"
}