#!/bin/bash
MAIL_TO="email"
LOG_PATH="/path/to/access.log"
SITE_NAME="sitename"

cat ${LOG_PATH} | grep -v manager | grep --color -e '^.*POST.*200.*$'
if [ "$?" -eq 0 ]
    then
        echo "`date` POST-req found"
        echo "send report"
        cat  ${LOG_PATH} | grep -v manager | grep --color -e '^.*POST.*200.*$' | mail -s "suspicious POST activity on ${SITE_NAME}" ${MAIL_TO}
    else
        echo "`date` POST-req not found"
fi
