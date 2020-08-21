awsRegion                   = "us-west-2"
aws_profile                 = "myaws"
myip                        = "98.234.248.72/32"


ami_id                      = "ami-0873b46c45c11058d"
instance_type               = "t2.micro"
root_volume_size            = "8"
ebs_volume_size           = "1"
//iam_instance_profile_of_instance_role = "xxxxx"
key_name                    = "myawskey"
public_min_size             = "1"
public_max_size             = "1"
user_data                   = "autoscaling_group/public_user_data.tpl"
private_max_size            = 1
private_min_size            = 1
private_user_data           = "autoscaling_group/private_user_data.tpl"
