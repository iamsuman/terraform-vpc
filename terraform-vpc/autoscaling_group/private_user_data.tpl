#!/bin/bash -xe

#mkfs -t xfs /dev/sdb
#mkdir /data
#mount /dev/sdb /data
#mkdir -p /data/logs/
#chown -R ec2-user:ec2-user /data/logs/

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "####### `date +"%Y-%m-%d %T %Z"` -> START: userdata execution ####### "
echo "####### `date +"%Y-%m-%d %T %Z"` -> SUCCESS: userdata execution ####### "