#!/bin/bash

startsystemd()
{
     exec /usr/lib/systemd/systemd --system --unit=basic.target
}



emailcfg()
{
    
    # echo "127.0.0.1 localhost localhost.localdomain $(hostname)">>/etc/hosts
     echo 'echo 127.0.0.1 localhost localhost.localdomain $(hostname) >> /etc/hosts' >> /etc/rc.d/rc.local
     echo 'echo AuthInfo:email-smtp.us-west-2.amazonaws.com \"U:root\" \"I:$SENDMAIL_USER\" \"P:$SENDMAIL_PASS\" \"M:PLAIN\" > /etc/mail/authinfo'  >> /etc/rc.d/rc.local
     echo 'makemap hash /etc/mail/authinfo.db < /etc/mail/authinfo'  >> /etc/rc.d/rc.local


     sleep 3
     systemctl enable rc-local
     systemctl enable sendmail
     systemctl enable saslauthd

     sleep 1
     systemctl start rc-local
     systemctl restart sendmail
     systemctl start saslauthd
     # Use the following to test, BUT I recommend remove it before upload to ECR or Docker Hub
     # exec printf 'Subject: Test\nFrom: your.name@emailtest.com\nTo: your.name@emailtest.com\n' | sendmail -i -t -f your.name@emailtest.com your.name@emailtest.com
     # exit 0
 }

#startsystemd
emailcfg
exec /usr/lib/systemd/systemd --system --unit=basic.target