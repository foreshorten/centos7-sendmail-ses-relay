# centos7-sendmail-ses-relay
This is a CentOS7 systemd image with email replay capabilities using AWS SES.  This image has sendmail installed and is configured as an smtp relay to send emails out through amazon SES as the host (sendmail SMART_HOST).

The following will add your [Amazon SES SMTP credentials](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/smtp-credentials.html) as your Docker variables (-e):
|Name| Description |
|--|--|
|SENDMAIL_USER| Amazon SES SMTP username|
|SENDMAIL_PASS| Amazon SES SMTP password
**Example:**

    docker run -it -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /run -e SENDMAIL_USER=<SES_IAM_USER> -e SENDMAIL_PASS=<SES_IAM_PASS> foreshorten/centos7-sendmail-ses-relay


NOTE: The "From:" email must be verified before sending emails out** ([Amazon SES requires that you verify your _identities_ (the domains or email addresses that you send email from) to confirm that you own them, and to prevent unauthorized use.](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-email-addresses.html?icmpid=docs_ses_console))
