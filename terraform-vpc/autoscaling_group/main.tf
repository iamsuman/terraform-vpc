resource "aws_launch_configuration" "bastion_lc" {
  name_prefix          = "ec2-lc-"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  security_groups      = ["${var.ec2_security_groups}"]
  associate_public_ip_address = "true"
  user_data            = var.user_data
//  iam_instance_profile = "${var.iam_instance_profile_of_instance_role}"
  key_name             = "${var.key_name}"

  root_block_device  {
    volume_size        = "${var.root_volume_size}"
    volume_type        = "gp2"
  }
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "${var.ebs_volume_size}"
    encrypted = true
    volume_type = "gp2"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion_asg" {
  name                 = "${aws_launch_configuration.bastion_lc.name}_asg"
  launch_configuration = "${aws_launch_configuration.bastion_lc.name}"
  min_size             = "${var.public_min_size}"
  max_size             = "${var.public_max_size}"
  vpc_zone_identifier  = var.vpc_subnet
  lifecycle {
    create_before_destroy = true
  }
  tags = [
    {
      key                 = "Name"
      value               = "mybastion"
      propagate_at_launch = true
    }
  ]
}

resource "aws_launch_configuration" "private_lc" {
  name_prefix          = "ec2-lc-"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  security_groups      = ["${var.private_ec2_security_groups}"]
  associate_public_ip_address = "false"
  user_data            = "${var.private_user_data}"
  //  iam_instance_profile = "${var.iam_instance_profile_of_instance_role}"
  key_name             = "${var.key_name}"

  root_block_device  {
    volume_size        = "${var.root_volume_size}"
    volume_type        = "gp2"
  }
  //  ebs_block_device {
  //    device_name = "/dev/sdb"
  //    volume_size = "${var.ebs_volume_size}"
  //    encrypted = true
  //    volume_type = "gp2"
  //  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "private_asg" {
  name                 = "${aws_launch_configuration.private_lc.name}_asg"
  launch_configuration = "${aws_launch_configuration.private_lc.name}"
  min_size             = "${var.private_min_size}"
  max_size             = "${var.private_max_size}"
  vpc_zone_identifier  = var.private_vpc_subnet
  lifecycle {
    create_before_destroy = true
  }
  tags = [
    {
      key                 = "Name"
      value               = "mydb"
      propagate_at_launch = true
    }
  ]
}