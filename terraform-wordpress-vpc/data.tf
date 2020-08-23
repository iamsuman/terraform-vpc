data "aws_instance" "public1" {
  filter {
    name   = "tag:Name"
    values = ["mypublic-ec2"]
  }
  depends_on = [
    module.autoscaling_group_web
  ]
}

data "aws_instance" "mydb1" {
  filter {
    name   = "tag:Name"
    values = ["mydb"]
  }
  depends_on = [
    module.autoscaling_group_db
  ]
}

data "template_file" "public-bootstrap-template" {
  template = file(var.user_data)
  vars = {
    DB_NAME   = var.DB_NAME
    USER_NAME = var.USER_NAME
    DB_PASS   = var.DB_PASS
    DB_HOST   = data.aws_instance.mydb1.private_ip
//    DB_HOST   = "10.0.0.0"
  }
}
data "template_file" "private-bootstrap-template" {
  template = file(var.private_user_data)
}
