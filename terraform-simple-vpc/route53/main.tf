resource "aws_route_table" "rr1" {
  vpc_id = var.vpcid
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igwid
  }
  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "route1" {
  route_table_id = aws_route_table.rr1.id
  subnet_id = var.public_subnet_id
}

resource "aws_eip" "ngw_eip" {
  vpc      = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw_eip.id
  subnet_id     = var.public_subnet_id
}

resource "aws_route_table" "rr2" {
  vpc_id = var.vpcid
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "private"
  }
}
resource "aws_route_table_association" "rr2_route1" {
  route_table_id = aws_route_table.rr2.id
  subnet_id = var.private_subnet_id
}