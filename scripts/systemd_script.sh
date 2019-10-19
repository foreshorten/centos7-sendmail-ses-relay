#!/bin/bash

startsystemd()
{
     systemctl enable rc-local
     systemctl enable sendmail
     systemctl enable saslauthd
     #exec /usr/lib/systemd/systemd --system --unit=basic.target
     /usr/lib/systemd/systemd --system --unit=basic.target


}



emailcfg()
{
    
    # echo "127.0.0.1 localhost localhost.localdomain $(hostname)">>/etc/hosts
     echo 'echo 127.0.0.1 localhost localhost.localdomain $(hostname) >> /etc/hosts' >> /etc/rc.d/rc.local
     echo 'echo AuthInfo:email-smtp.us-west-2.amazonaws.com \"U:root\" \"I:$SENDMAIL_USER\" \"P:$SENDMAIL_PASS\" \"M:PLAIN\" > /etc/mail/authinfo'  >> /etc/rc.d/rc.local
     echo 'makemap hash /etc/mail/authinfo.db < /etc/mail/authinfo'  >> /etc/rc.d/rc.local

     setsid bash /root/taskscript.sh &
 }

#startsystemd
emailcfg
exec /usr/lib/systemd/systemd --system --unit=basic.target
echo "stopping container"
echo "exited $0"
