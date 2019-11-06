# Amazon Simple Email Service (Amazon SES) - Centos7 Sendmail SES SMTP Relay
This is a CentOS7 systemd image with email **SMTP Relay** capabilities to send outbound through AWS SES.  This image has sendmail installed and is configured as an smtp relay to send emails out through amazon SES host (sendmail SMART_HOST).  This Dockerfile is currently configured for default us-west2 region but can be changed with Docker variable below. 

This Docker image was originally created to be a _Parent Image_ for subsequent Docker images to run tasks in AWS Elastic Container Service (ECS), however it can be run on Docker desktop, Docker host, ECS Service, ECS Task, etc.  The ECS Task Definition can only be run on **EC2 but not Fargate**, because this image depends on systemd to run sendmail and saslauthd.

The following are required Docker variables (-e):

| Name | Description |
| ---- | ------ |
| `SENDMAIL_USER` | Amazon SES SMTP username |
| `SENDMAIL_PASS` | Amazon SES SMTP password |
| `SEND_DOMAIN` | Domain you send from |
| `SMTP_ENDPOINT` | [Amazon SES SMTP endpoints](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/smtp-connect.html) |

Documentation for how to obtain your [Amazon SES SMTP credentials](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/smtp-credentials.html)

**Example docker run with smtp endpoint US West (Oregon) - *The Default*:**

    docker run --rm -it -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /run -e SENDMAIL_USER='<SMTP_IAM_USER>' -e SENDMAIL_PASS='<SMTP_IAM_PASS>' -e SEND_DOMAIN='<yourdomain.com>' foreshorten/centos7-sendmail-ses-relay
> **Note:** Adding the --rm to [Automatically remove the container when it exits](https://docs.docker.com/engine/reference/commandline/run/)

**Example docker run with smtp endpoint US East (N. Virginia) - email-smtp.us-east-1.amazonaws.com:**

    docker run --rm -it -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /run -e SENDMAIL_USER='<SMTP_IAM_USER>' -e SENDMAIL_PASS='<SMTP_IAM_PASS>' -e SEND_DOMAIN='<yourdomain.com>' -e SMTP_ENDPOINT='email-smtp.us-east-1.amazonaws.com' foreshorten/centos7-sendmail-ses-relay

**Example sendmail by cli to test:**

       printf 'Subject: Test\nFrom: yourname@example.com\nTo: yourname@example.com\n' | sendmail -i -t -f yourname@example.com yourname@example.com

NOTE: When sending emails the "From:" email must be verified before sending emails out.** [Amazon SES requires that you verify your _identities_ (the domains or email addresses that you send email from) to confirm that you own them, and to prevent unauthorized use.](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-email-addresses.html?icmpid=docs_ses_console)

I have added EXPOSE 25 to Dockerfile, however it is receommended to only run with this port open if needed.   This image is intended to be used on internal networks only. 
