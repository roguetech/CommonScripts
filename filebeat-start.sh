#!/bin/sh
# Enter your action script here

logFile="/home/patrickroughan/`hostname -s`.$$"
email="patrick.roughan@globalpay.com"
echo "-------------------------------------------------------------------" > ${logFile}
host=`hostname -s`
subj="$hostname"
all="${host}: ${subj}"
echo "Before:" >> ${logFile}
/etc/init.d/filebeat status >> ${logFile}
/etc/init.d/filebeat start
sleep 5
echo "After:" >> ${logFile}
/etc/init.d/filebeat status >> ${logFile}
status=`/etc/init.d/filebeat status`
ps -ef | grep filebeat >> /home/patrickroughan/`hostname`.$$
echo "-------------------------------------------------------------------" >> ${logFile}
#all="${host}: ${status}"
cat ${logFile} | mail -s "${host} - filebeat status" ${email}
[ $? -ne 0 ] && cat ${logFile} | mutt -s "${all}" ${email};
rm -f ${logFile}
