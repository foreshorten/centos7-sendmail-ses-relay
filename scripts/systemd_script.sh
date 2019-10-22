#!/bin/bash

emailcfg()
     {
     setsid bash /root/emailcfg.sh &
     }

taskscript()
     {
     #PLACE your script below OR use the taskscript.sh file.  
     #NOTE: If you use your own scrpt, recommend having a 'sleep 3' at beginning (see the taskscript.sh) which allows time for IAM credentials to be loaded in /etc/mail/auth file
     setsid bash /root/taskscript.sh &
     }

emailcfg

taskscript

exec /usr/lib/systemd/systemd --system --unit=basic.target
echo "stopping container"
echo "exited $0"
