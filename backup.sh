#!/usr/bin/env bash

echo ""
echo "+-------------------------------------+"
echo "|           strrife backup            |"
echo "| https://github.com/strrife/backuper |"
echo "+-------------------------------------+"
echo ""

BKPDATE="weekday_`date +%w`"

HOME_DIR="$(dirname "$0")"
if [ ! -e "$HOME_DIR/backups"  ];then
	mkdir -p "$HOME_DIR"/backups
fi

# Ok, so now we're in the backups dir
rm -f "$HOME_DIR"/backups/mongo_"$BKPDATE".gz
mongodump --db test -o "$HOME_DIR"/backups/mongo_"$BKPDATE".gz