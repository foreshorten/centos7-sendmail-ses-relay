# centos7-sendmail-ses-relay
Sends emails through AWS SES using sendmail daemon 




** Has to be run with the Docker variables:
SENDMAIL_USER <SES_IAM_USER>
SENDMAIL_PASS <SES_IAM_PASS>

Example:
```
docker run -it -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /run -e SENDMAIL_USER=<SES_IAM_USER> -e SENDMAIL_PASS=<SES_IAM_PASS> foreshorten/centos7-sendmail-ses-relay