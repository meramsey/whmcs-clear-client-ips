Here is how to clear your WHMCS client last login IP’s and host entries automatically for privacy.

Probably not a popular modification, but running a security and privacy company we wanted to automate and prevent any unnecessary logging being done when clients login to the billing/support center.

These are stored in the table “tblclients” and in columns “ip” and “host”.
whmcs_database »Table: tblclients > ip,host

Replace the below values with your cPanel username and whmcs installations database_name, database_user, and database_user’s password. Please note that the password does need to be directly next to the “-p” so if your database user’s password was “SECRET” your value should look like “-pSECRET“

In my case, I created a new database user with only “update” privileges on the WHMCS database for this script.

To create the bash script manually:

This can be done via SSH via nano

nano whmcs-client-clear-ip.sh

Or via the cPanel FileManager create a new file named “whmcs-client-clear-ip.sh”

With the below lines:

#!/bin/sh
#Clear clients last login IP address in table tblclients > ip,host
/usr/bin/mysql -h "localhost" -u "database_username" "-pPasswordhere" -e "UPDATE tblclients SET ip = '', host = ''" database_name

#Clear Order Ipaddress in table tblorders > ipaddress
/usr/bin/mysql -h "localhost" -u "database_username" "-pPasswordhere" -e "UPDATE tblorders SET ipaddress = ''" database_name

Then in the cPanel cronjobs or via ssh “crontab -e” add the below cronjob to clear this every minute.

* * * * * /bin/sh /home/username/whmcs-client-clear-ip.sh >/dev/null 2>&1

To test if it’s working I recommend setting it to every 5 minutes like the below.

*/5 * * * * /bin/sh /home/username/whmcs-client-clear-ip.sh >/dev/null 2>&1

Then log in to a test account to generate a last login whmcs entry to that client in the database. Check it exists by going to your whmcs_database »Table: tblclients and look at the “ip” and “host” columns to the far right. If you see its there then you know you have an entry it will clear. See example below

Go change the cron back to run every minute and then refresh in another minute all those entries should always be empty unless you check a login that happened within 60-sec window between the cron running. It should look like the below if all is working correctly.

If it’s not working then run the command from the second line of the script in the command line via ssh first to see if there is an error or typo. If it is fix it then update the bash script and you should be all set.

Hope this helps someone else and also probably helpful for huge company’s to save space in their database from clients activity.