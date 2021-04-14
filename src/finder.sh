#!/bin/bash

for dir in $(ls -d */); do
cd $dir; git checkout . && git log -p > commits.dump; cd ..
grep -rnP -C25 "AKIA[A-Z0-9]{16}" --binary-files=text $dir | cut -c -500 >> akia.txt
grep -rniP -C25 "smtp\.sendgrid\.net|smtp\.mailgun\.org|smtp-relay\.sendinblue\.com|email-smtp\.(us|eu|ap|ca|cn|sa)-(central|(north|south)?(west|east)?)-[0-9]{1}\.amazonaws.com|smtp.tipimail.com|smtp.sparkpostmail.com|nexmo_key|nexmo_secret|smtp.deliverabilitymanager.net|smtp.mailendo.com|mail.smtpeter.com|mail.smtp2go.com|smtp.socketlabs.com|secure.emailsrvr.com|mail.infomaniak.com|smtp.pepipost.com|smtp.elasticemail.com|smtp25.elasticemail.com|pro.turbo-smtp.com|smtp-pulse.com|in-v3.mailjet.com" --binary-files=text $dir | cut -c -500 >> smtp.txt
for i in $(find $dir -name '*.env*' -type f); do
cat $i >> gigaenv.txt
done
done
