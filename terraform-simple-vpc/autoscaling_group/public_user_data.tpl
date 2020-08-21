#!/bin/bash -xe

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "####### `date +"%Y-%m-%d %T %Z"` -> START: userdata execution ####### "
yum install -y jq
mkfs -t xfs /dev/sdb
mkdir -p /var/www/html
mount /dev/sdb /var/www/html
# check via blkid
echo "/dev/sdb                                      /var/www/html xfs defaults,nofail  0  2" >> /etc/fstab
chown -R ec2-user:ec2-user /var/www/html
yum -y update
yum -y install httpd
systemctl enable httpd
systemctl start httpd

#Get instance identity
instance_identity=$(curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document/)
EC2_INSTANCE_PRIVATE_IP=$(echo $${instance_identity} | jq -r .privateIp)
EC2_INSTANCE_PUBLIC_IP=$(curl --silent http://169.254.169.254/latest/meta-data/public-ipv4)

cd /var/www/html
cat > index.html <<EOF
"Hello AWS World"
"EC2_INSTANCE_PUBLIC_IP: $EC2_INSTANCE_PUBLIC_IP"
"EC2_INSTANCE_PRIVATE_IP: $EC2_INSTANCE_PRIVATE_IP"
EOF

# if neeed to create partition
# gdisk /dev/xvdb
# pvcreate /dev/xvdb1
# vgcreate examplegroup1 /dev/xvdb1
# lvcreate -n lvexample1 -L 1000M examplegroup1
# mkfs -t xfs /dev/examplegroup1/lvexample1
# mount /dev/examplegroup1/lvexample1 /var/www/html

echo "####### `date +"%Y-%m-%d %T %Z"` -> SUCCESS: userdata execution ####### "





