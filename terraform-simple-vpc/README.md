# terraform-vpc
Creates following
```
VPC
1 public and 1 private subnet
1 public and 1 private security group
Public and Private Route table
Nat Gateway
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

Output
```aidl
Outputs:
private_subnets = subnet-xxxx
public_ip = xxx.xxx.xxx.xxx
public_subnets = subnet-xxxxx
vpcid = vpc-xxxxx
```

ssh access
```aidl
1 Assumption: key is saved as ~/.ssh/myawskey.pem
update ~/.ssh/config as below

ServerAliveInterval 30
ServerAliveCountMax 1200
Host myec2
    Hostname xxx.xxx.xxx.xxx
    ForwardAgent=yes
    User ec2-user
    IdentityFile ~/.ssh/myawskey.pem
Host mydb
  Hostname xxx.xxx.xxx.xxx
  User ec2-user
  IdentityFile ~/.ssh/myawskey.pem
  ProxyCommand ssh myec2 -W %h:%p
  ForwardAgent yes

then
ssh myec2
ssh mydb
```