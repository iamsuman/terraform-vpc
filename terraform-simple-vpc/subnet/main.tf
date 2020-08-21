resource "aws_subnet" "public1" {
  vpc_id            = var.vpcid
  cidr_block        = "10.0.0.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Public1"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = var.vpcid
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Private1"
  }
}

data "aws_availability_zones" "available" {}


