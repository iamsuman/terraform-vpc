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
yum -y install httpd php
systemctl enable httpd
systemctl start httpd

wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
rm -rf latest.tar.gz
cd wordpress
cp wp-config-sample.php wp-config.php

sed -i 's/database_name_here/${DB_NAME}/g' wp-config.php
sed -i 's/username_here/${USER_NAME}/g' wp-config.php
sed -i 's/password_here/${DB_PASS}/g' wp-config.php
sed -i 's/localhost/${DB_HOST}/g' wp-config.php

echo "####### `date +"%Y-%m-%d %T %Z"` -> SUCCESS: userdata execution ####### "







