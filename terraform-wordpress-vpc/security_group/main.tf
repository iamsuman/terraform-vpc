resource "aws_security_group" "public_sg" {
  name = "public-sg"
  description = "Public Security Group"
  vpc_id = var.vpcid
  ingress {
    description = "ssh from local machine"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.myip}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "public_sg"
  }

}

resource "aws_security_group" "private_sg" {
  name = "ec2-private-sg"
  description = "EC2 Security Group"
  vpc_id = var.vpcid
  ingress {
    description = "ssh from bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.public_sg.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ec2_private_sg"
  }

}
resource "aws_security_group_rule" "public_ingress" {
  type = "ingress"
  from_port = 0
  to_port = 80
  protocol = "tcp"
  cidr_blocks       = [var.myip]
  security_group_id = aws_security_group.public_sg.id
  description = "http access to public"
}

resource "aws_security_group_rule" "private_ingress_mysql" {
  type = "ingress"
  from_port = 0
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = aws_security_group.public_sg.id
  security_group_id = aws_security_group.public_sg.id
  description = "http access to public"
}