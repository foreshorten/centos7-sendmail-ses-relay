# Amazon Simple Email Service (Amazon SES) - Centos7 Sendmail SES SMTP Relay
This is a CentOS7 systemd image with email **SMTP Relay** capabilities to send outbound through AWS SES.  This image has sendmail installed and is configured as an smtp relay to send emails out through amazon SES host (sendmail SMART_HOST).  This Dockerfile is currently only configured for us-west2 region. 

This Docker image was originally created to be a _Parent Image_ for subsequent Docker images.  It can be run as a Service or Task in Amazon Elastic Container Service (Amazon ECS).    The ECS Task Definition can only be run on **EC2 but not Fargate**, because this image depends on systemd to run sendmail and saslauthd. 

The following are required Docker variables (-e):

| Name | Description |
| ---- | ------ |
| `SENDMAIL_USER` | Amazon SES SMTP username |
| `SENDMAIL_PASS` | Amazon SES SMTP password |
| `SEND_DOMAIN` | Domain you send from |
| `SMTP_ENDPOINT` | [Amazon SES SMTP endpoints](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/smtp-connect.html) |

Documentation for how to obtain your [Amazon SES SMTP credentials](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/smtp-credentials.html)

**Example:**

    docker run -it -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /run -e SENDMAIL_USER=<SMTP_IAM_USER> -e SENDMAIL_PASS=<SMTP_IAM_PASS> foreshorten/centos7-sendmail-ses-relay


NOTE: When sending emails the "From:" email must be verified before sending emails out.** [Amazon SES requires that you verify your _identities_ (the domains or email addresses that you send email from) to confirm that you own them, and to prevent unauthorized use.](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-email-addresses.html?icmpid=docs_ses_console)

I have added EXPOSE 25 to Dockerfile in the case it's needed.  However, it is recommended to only expose this port if needed.   Also, this image is intended to be used on internal networks only. 
