#!/bin/bash

sleep 3


# Use the following to test, BUT I recommend remove it before upload to ECR or Docker Hub
# exec printf 'Subject: Test\nFrom: your.name@emailtest.com\nTo: your.name@emailtest.com\n' | sendmail -i -t -f your.name@emailtest.com your.name@emailtest.com

## You can use this as a system halt iF you are running task
##NOTE: To use halt, you need to have /sys/fs/cgroup readonly and /run tmpfs otherwise you will trigger a shutdown of the Docker Linux HOST
#systemctl halt

##This will show you details if your email fails
systemctl status sendmail -l

exit 0