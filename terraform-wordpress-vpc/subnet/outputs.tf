output "public_subnet_id" {
  value = aws_subnet.public1.id
}

output "private_subnet_id" {
  value = aws_subnet.private1.id
}