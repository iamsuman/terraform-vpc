data "aws_instance" "public1" {
  filter {
    name   = "tag:Name"
    values = ["mypublic-ec2"]
  }
  depends_on = [
    module.autoscaling_group
  ]
}

data "template_file" "public-bootstrap-template" {
  template = file(var.user_data)
}
data "template_file" "private-bootstrap-template" {
  template = file(var.private_user_data)
}