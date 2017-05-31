
#!/bin/bash
####################
# http://wiki.opennet.ru/Incrontab
#incrontab -l
#/path/to/folder IN_CLOSE_WRITE /path/to/autoban.sh $@/$#
####################
#LOG=/tmp/result.txt
INCRON_FILE_NAME=$(echo "$1")
LIST=$(cat ${INCRON_FILE_NAME})
####################
# http://linuxru.org/linux/324
#ipset -F autoban
#INCRON_FILE_NAME=autoban
#echo "OK" >> /tmp/result.txt
#echo "${INCRON_FILE_NAME}" >> ${LOG}
#echo "${LIST}" >> ${LOG}
####################
if [-e ${INCRON_FILE_NAME}]
    then
    echo "file exist"
    else
    ipset -F autoban
fi
########
ipset create autoban hash:ip hashsize 131072 maxelem 2000000
for ipaddr in ${LIST}
do
  ipset -A autoban $ipaddr
done

rm ${INCRON_FILE_NAME}
###################
