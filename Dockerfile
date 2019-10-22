FROM centos/systemd

ENV SENDMAIL_USER <SMTP_IAM_USER>
ENV SENDMAIL_PASS <SMTP_IAM_PASS>
ENV SEND_DOMAIN   example.com
ENV SMTP_ENDPOINT  email-smtp.us-west-2.amazonaws.com

COPY scripts/*.sh /root/

#Adding hostname so sendmail wont delay install
RUN echo 127.0.0.1 localhost localhost.localdomain $(hostname) >> /etc/hosts && \
yum install -y deltarpm sendmail sendmail-cf file poppler-utils cyrus-sasl-plain

#Adding relay config to sendmail.mc
#Config below is from https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-sendmail.html --  ty Amazon :)
RUN sed -i -e '/lan)dnl/ a define(`RELAY_MAILER_ARGS'\'', `TCP $h 25'\'')dnl' /etc/mail/sendmail.mc && \
sed -i -e '/lan)dnl/ a define(`confAUTH_MECHANISMS'\'', `LOGIN PLAIN'\'')dnl' /etc/mail/sendmail.mc && \
sed -i -e '/lan)dnl/ a FEATURE(`authinfo'\'', `hash -o /etc/mail/authinfo.db'\'')dnl' /etc/mail/sendmail.mc && \
sed -i -e '/lan)dnl/ a MASQUERADE_AS(`example.com'\'')dnl' /etc/mail/sendmail.mc && \
sed -i -e '/lan)dnl/ a FEATURE(masquerade_envelope)dnl' /etc/mail/sendmail.mc && \
sed -i -e '/lan)dnl/ a FEATURE(masquerade_entire_domain)dnl' /etc/mail/sendmail.mc  && \
sed -i -e '/lan)dnl/ a define(`SMART_HOST'\'', `email-smtp.us-west-2.amazonaws.com'\'')dnl' /etc/mail/sendmail.mc && \
chmod 666 /etc/mail/sendmail.cf  && \
m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf &&\
chmod 644 /etc/mail/sendmail.cf

RUN yum update -y

EXPOSE 25

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/root/systemd_script.sh"]
