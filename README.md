# MySQL Slave Status Mail
A simple shell script for checking the status of MySQL's replication based on Linux system.

Normally, SLAVE will block if it encounter some unexpected errors when it syncs with MASTER. 
This script can help sending the email of the status.

## Function
1. Automatically sending mail
2. Monthly report checking

## Usage
1. Create a user for showing status only.
```
CREATE USER 'user'@'host' IDENTIFIED BY 'password'
GRANT REPLICATION CLIENT ON *.* to 'user'@'host'
```

2. Replace the values of the variables in the script.
*check_slave.sh*
```
user=your-username
pass=your-password
email=your-email-address
...
subject=email-subject
content=email-content
```

3. Schedule (Optional, based on linux)
```
sudo touch /var/log/mysql_slave.log
sudo crontab -e
```
**Example:**
```
# Every morning at 7:00
0 7 * * * /path/to/check_slave.sh &> /dev/null
```
Crontab will email the user if the jobs have the output. In our case it may display `mysql.bin: [Warning] Using a password on the command line interface can be insecure.` when executing the script. Adding `&> /dev/null` can prevent this.
Alternatively, adding `MAILTO=""` to the top of the file is antoher choice.
