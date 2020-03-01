#!/usr/bin/env bash
set -ex
[ -n "$1" ] || exit 1
cd /var/www
SHOP_NAME=$1
DB_CREDENTIALS=$(
php <<PHP
<?php
require '$SHOP_NAME/config/settings.inc.php';
print(_DB_USER_ . ' ' . _DB_PASSWD_ . ' ' . _DB_NAME_ . PHP_EOL);
?>
PHP
)
read DB_USER DB_PASSWD DB_NAME <<< $DB_CREDENTIALS
mysqldump -u $DB_USER -p$DB_PASSWD $DB_NAME > $SHOP_NAME/$DB_NAME.sql
7z -xr!backup -xr!backups -xr!cache a "$HOME/backup/$SHOP_NAME-backup-$(date +%F-%T).7z" $(realpath "$SHOP_NAME")
rm $SHOP_NAME/$DB_NAME.sql