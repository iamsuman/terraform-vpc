resource "aws_subnet" "public" {
  vpc_id            = var.vpcid
  count            = length(data.aws_availability_zones.available.names)
  cidr_block        = "10.0.${0+count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "Public${count.index}"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = var.vpcid
  count             = length(data.aws_availability_zones.available.names)
  cidr_block        = "10.0.${10+count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "Private${count.index}"
  }
}


data "aws_availability_zones" "available" {}


