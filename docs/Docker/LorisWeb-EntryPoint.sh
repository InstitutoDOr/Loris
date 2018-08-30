#!/bin/bash
set -e

source /etc/apache2/envvars
# if [ ! -e project/config.xml.tmp ]; then
if [ ! -e project/config.xml ]; then
    if [ -z "$LORIS_ADDRESS" ]; then
         IPAddress=`ip addr | grep 'eth0' | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`
         echo >&2 "LORIS_ADDRESS not specified. Assuming \"$IPAddress\""
         LORIS_ADDRESS=$IPAddress
    fi

    RANDOMPASS=`date | md5sum | head -c 16`
    if [ -z "$LORIS_SQL_DB" ]; then
         echo >&2 "WARNING: LORIS_SQL_DB not set. Assuming \"LorisDB\""
         LORIS_SQL_DB="LorisDB"
     fi
    if [ -z "$LORIS_SQL_HOST" ]; then
         echo >&2 "WARNING: LORIS_SQL_HOST not set. Assuming \"mysql\""
         LORIS_SQL_HOST="mysql"
     fi

     if [ -z "$LORIS_SQL_PASSWORD" ]; then
         echo >&2 "error: Loris is uninitialized and LORIS_SQL_PASSWORD not set. Please specify LORIS_SQL_PASSWORD";
         exit 1
     fi

     if [ -z "$LORIS_SQL_USER" ]; then
         echo >&2 "LORIS_SQL_USER not specified. Assuming \"loris\""
         LORIS_SQL_USER="loris"
     fi

     sed -e "s#%USERNAME%#$LORIS_SQL_USER#g" \
         -e "s#%PASSWORD%#$LORIS_SQL_PASSWORD#g" \
         -e "s#%DATABASE%#$LORIS_SQL_DB#g" \
         -e "s#%HOSTNAME%#$LORIS_SQL_HOST#g" \
         < docs/config/config.xml > project/config.xml

    # Waiting for database
    until mysqladmin ping -h"$LORIS_SQL_HOST" --user=$LORIS_SQL_USER --password="$LORIS_SQL_PASSWORD" --silent; do
        >&2 echo "MySQL is unavailable - sleeping. Check again after 10 seconds."
        sleep 3
    done

    TEMP_FILE=/tmp/mysql-first-time.sql
    cat $(ls /var/www/loris/SQL/0000-*.sql | sort) >> $TEMP_FILE
    mysql $LORIS_SQL_DB -h$LORIS_SQL_HOST --user=$LORIS_SQL_USER --password="$LORIS_SQL_PASSWORD" < $TEMP_FILE
    rm $TEMP_FILE

     echo "Configuring Loris to be accessible at http://$LORIS_ADDRESS. Please update configuration through admin module using admin user and password $RANDOMPASS."
     mysql $LORIS_SQL_DB -h$LORIS_SQL_HOST --user=$LORIS_SQL_USER --password="$LORIS_SQL_PASSWORD" -A -e "UPDATE Config SET Value='/var/www/loris/' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='base')"
     mysql $LORIS_SQL_DB -h$LORIS_SQL_HOST --user=$LORIS_SQL_USER --password="$LORIS_SQL_PASSWORD" -A -e "UPDATE Config SET Value='$LORIS_ADDRESS' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='host')"
     mysql $LORIS_SQL_DB -h$LORIS_SQL_HOST --user=$LORIS_SQL_USER --password="$LORIS_SQL_PASSWORD" -A -e "UPDATE Config SET Value='http://$LORIS_ADDRESS' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='url')"

     # Update the password
     DB_PASS=$(php -r "echo password_hash('$RANDOMPASS', PASSWORD_DEFAULT);")
     mysql $LORIS_SQL_DB -h$LORIS_SQL_HOST --user=$LORIS_SQL_USER --password="$LORIS_SQL_PASSWORD" -A -e "UPDATE users SET Password_hash='$DB_PASS', UserID='admin' WHERE ID=1";


fi

exec "$@"
