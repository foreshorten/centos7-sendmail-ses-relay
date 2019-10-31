#!/bin/bash

emailcfg()
{
	setsid bash /root/emailcfg.sh &
}

taskscript()
{
    #PLACE your script below OR use the taskscript.sh file
#NOTE: If you use your own scrpt, its recommend having a 'sleep 3' at beginning (see the taskscript.sh) which allows time for IAM credentials to be loaded in /etc/mail/authinfo file
	setsid bash /root/taskscript.sh &
}

emailcfg

taskscript

exec /usr/lib/systemd/systemd --systemd --unit=basic.target
echo "exited $0"
