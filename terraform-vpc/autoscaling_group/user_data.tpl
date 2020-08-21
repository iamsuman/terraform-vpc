#!/bin/bash -xe

mkfs -t xfs /dev/sdb
mkdir -p /var/www/html
mount /dev/sdb /var/www/html
chown -R ec2-user:ec2-user /var/www/html

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "####### `date +"%Y-%m-%d %T %Z"` -> START: userdata execution ####### "
yum -y update
yum -y install httpd
cd /var/www/html
cat > index.html <<EOF
"Hello AWS World"
EOF

df -h > screen-shot1.png
pwd; ls -l >> screen-shot2.png



service httpd start

echo "####### `date +"%Y-%m-%d %T %Z"` -> SUCCESS: userdata execution ####### "