#!/bin/bash

     echo 127.0.0.1 localhost localhost.localdomain $(hostname) >> /etc/hosts
     echo AuthInfo:email-smtp.us-west-2.amazonaws.com \"U:root\" \"I:$SENDMAIL_USER\" \"P:$SENDMAIL_PASS\" \"M:PLAIN\" > /etc/mail/authinfo

sleep 1

     systemctl start sendmail
     systemctl start saslauthd

     systemctl enable sendmail
     systemctl enable saslauthd


exit 0