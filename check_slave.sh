#!/bin/bash

user=your-username
pass=your-password
email=email-address
log_file=/var/log/mysql_status.log

function send_mail {
        # $1:contents, $2:subject
        echo "$1" | mail -s "$2" "$email"
        exit
}

function append_log {
        echo "$(date) : $1" >> $log_file
}

# Normal Routine for checking the status
result=$(mysql -u$user -p$pass -e 'show slave status\G' | grep Last_SQL_Error: | sed -e 's/ *Last_SQL_Error: //')

if [ -n "$result" ]
then
        append_log "$result , email sent. ($email)"
        subject=""
        content="Last_SQL_Error: $result"
        send_mail "$content" "$subject"
else
        append_log "No error."
fi

# First day of the month: Monthly Report
nowday=$(date '+%d')
result_all=$(mysql -u$user -p$pass -e 'show slave status\G')

if [ $nowday == '01' ]
then
	subject=""
	content=""
	send_mail "$content" "$subject"
	append_log "Monthly report sent. ($email)"