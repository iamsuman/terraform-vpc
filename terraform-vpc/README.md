# terraform-vpc
Creates following
```
VPC
1 public and 1 private subnet
1 public and 1 private security group
Private Route table
Internet Gateway
Launch config and autoscaling group 
   ==> This will create 1 ec2 instance each in public and private subnets
```

Command
```
terraform init
terraform apply -var-file="config/variables.tfvars" \
-var "public_min_size=1" -var "public_max_size=1" \
-var "private_min_size=1" -var "private_max_size=1"
```