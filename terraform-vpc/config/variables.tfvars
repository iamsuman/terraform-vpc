awsRegion = "us-west-2"
aws_profile = "myaws"
myip = "98.234.248.72/32"


ami_id = "ami-0873b46c45c11058d"
instance_type = "t2.micro"
root_volume_size = "10"
//ebs_volume_size = "250"
//iam_instance_profile_of_instance_role = "xxxxx"
key_name = "myawskey"
min_size = "1"
max_size = "1"
user_data = "autoscaling_group/user_data.tpl"
