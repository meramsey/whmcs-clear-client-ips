#!/bin/bash
## Author: Michael Ramsey
## Objective: WHMCS client last login ip log clearing script
## https://whattheserver.com/whmcs-client-last-login-ip-log-clearing-script/
## https://gitlab.com/mikeramsey/whmcs-clear-client-ips
## How to use.
# ./whmcs-clear-client-ips.sh
# sh whmcs-clear-client-ips.sh
# How to setup as a cron
# * * * * * /bin/sh /home/username/whmcs-clear-client-ips >/dev/null 2>&1

#Configure here
DB="database_name"
DBUSER="database_username"
DBPASS="Passwordhere"
#Stop configuring


#Clear clients last login IP address in table tblclients > ip,host
#/usr/bin/mysql -h "localhost" -u "database_username" "-pPasswordhere" -e "UPDATE tblclients SET ip = '', host = ''" database_name

/usr/bin/mysql -h "localhost" -u "$DBUSER" "-p$DBPASS" -e "UPDATE tblclients SET ip = '', host = ''" $DB

#Clear Order Ipaddress in table tblorders > ipaddress
#/usr/bin/mysql -h "localhost" -u "database_username" "-pPasswordhere" -e "UPDATE tblorders SET ipaddress = ''" database_name

/usr/bin/mysql -h "localhost" -u "$DBUSER" "-p$DBPASS" -e "UPDATE tblorders SET ipaddress = ''" $DB