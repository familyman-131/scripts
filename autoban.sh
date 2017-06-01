
#!/bin/bash
####################
# http://wiki.opennet.ru/Incrontab
#incrontab -l
#/path/to/folder IN_CLOSE_WRITE /path/to/autoban.sh $@/$#
####################
DATE=`date +%Y-%m-%d:%H:%M:%S`
#LOG=/path/to/debug.log
INCRON_FILE_NAME=$(echo "$1")
LIST=$(cat ${INCRON_FILE_NAME})
####################
# http://linuxru.org/linux/324
#ipset -F autoban
#echo "OK" >> ${LOG}
#echo "${INCRON_FILE_NAME}" >> ${LOG}
#echo "${LIST}" >> ${LOG}
####################
echo "${INCRON_FILE_NAME}"  | grep -q purge.autoban
FILE_EXT_CHK=$(echo "$?")
if [ ${FILE_EXT_CHK} = 0 ]
    then
    echo "file empty ${DATE}"  #>> ${LOG}
    ipset -F autoban
#    echo "" > /path/to/autobannediplist.txt
    rm ${INCRON_FILE_NAME}
    exit
    else
    echo "file full ${DATE}"  #>> ${LOG}
fi
########
ipset create autoban hash:ip hashsize 131072 maxelem 2000000
for ipaddr in ${LIST}
do
  ipset -A autoban $ipaddr
#  echo "$ipaddr  ${DATE}" >> /path/to/autobannediplist.txt
done
########
rm ${INCRON_FILE_NAME}
###################
