resource "aws_security_group" "bastion_sg" {
  name = "bastion-sg"
  description = "Bastion Security Group"
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
    Name = "bastion_sg"
  }

}

resource "aws_security_group" "ec2_private_sg" {
  name = "ec2-private-sg"
  description = "EC2 Security Group"
  vpc_id = var.vpcid
  ingress {
    description = "ssh from bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.bastion_sg.id}"]
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