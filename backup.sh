#!/usr/bin/env bash

echo ""
echo "+-------------------------------------+"
echo "|           strrife backup            |"
echo "| https://github.com/strrife/backuper |"
echo "+-------------------------------------+"
echo ""

DB="$1"
if [ ! "$DB" ];then
    echo "You should specify the database"
    exit
fi

BKPDATE="weekday_`date +%w`"
HOME_DIR="$(dirname "$0")"
if [ ! -e "$HOME_DIR/backups"  ];then
	mkdir -p "$HOME_DIR"/backups
fi

# Ok, so now we're in the backups dir
rm -f "$HOME_DIR"/backups/mongo_"$BKPDATE".gz
mongodump --db "$DB" -o "$HOME_DIR"/backups/mongo_"$BKPDATE"
zip -r "$HOME_DIR"/backups/mongo_"$BKPDATE".zip "$HOME_DIR"/backups/mongo_"$BKPDATE"
rm -rf "$HOME_DIR"/backups/mongo_"$BKPDATE"
php "$HOME_DIR"/upload/upload.php dropbox "$HOME_DIR"/backups/mongo_"$BKPDATE".zip