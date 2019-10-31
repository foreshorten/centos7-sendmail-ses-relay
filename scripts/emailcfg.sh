#!/bin/bash
     echo 127.0.0.1 localhost localhost.localdomain $(hostname) >> /etc/hosts
     echo AuthInfo:$SMTP_ENDPOINT \"U:root\" \"I:$SENDMAIL_USER\" \"P:$SENDMAIL_PASS\" \"M:PLAIN\" > /etc/mail/authinfo
     sed -i -e "s/example.com/$SEND_DOMAIN/g" /etc/mail/sendmail.mc
     sed -i -e "s/email-smtp.us-west-2.amazonaws.com/$SMTP_ENDPOINT/g" /etc/mail/sendmail.mc
sleep 2
systemctl start sendmail
systemctl start saslauthd

systemctl enable sendmail
systemctl enable saslauthd
exit 0
