# terraform-vpc
Creates following
```
VPC
1 public and 1 private subnet
1 public and 1 private security group
Private Route table
Internet Gateway
Launch config and autoscaling group ==> This will create an ec2 instance
```

Command
```
terraform apply -var-file="config/variables.tfvars" -var "min_size=1" -var "max_size=1"
```