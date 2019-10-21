#!/bin/bash

emailcfg()
     {
     setsid bash /root/emailcfg.sh &
     }

taskscript()
     {
     setsid bash /root/taskscript.sh &
     systemctl status sendmail

     }

emailcfg

taskscript

exec /usr/lib/systemd/systemd --system --unit=basic.target
echo "stopping container"
echo "exited $0"
