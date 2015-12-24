#!/usr/bin/env bash

echo ""
echo "+-------------------------------------+"
echo "|           strrife backup            |"
echo "| https://github.com/strrife/backuper |"
echo "+-------------------------------------+"
echo ""

USERNAME=$1
BKPDATE="weekday_`date +%w`"

if ! "$USERNAME"; then
    echo "Specify the username as a command-line argument";
fi

exit
HOME_DIR="/home/$USERNAME"
if [ ! -e "$HOME_DIR"  ];then
    # Mac, huh
	HOME_DIR="/Users/$USERNAME"
	if [ ! -e "$HOME_DIR"  ];then
        echo "Damn, can't find the home dir. Have you specified the username param?"
        exit -1
    fi
fi

echo "$HOME_DIR"
if [ ! -e "$HOME_DIR/backups"  ];then
	mkdir -p "$HOME_DIR"/backups
#	chown "$USERNAME.$USERNAME" "$HOME_DIR"/backups
fi

# Ok, so now we're in the backups dir
rm -f "$HOME_DIR"/backups/mongo_"$BKPDATE".gz
mongodump --db test -o "$HOME_DIR"/backups/mongo_"$BKPDATE".gz



#/usr/bin/php "$HOME_DIR"/public_html/backup/upload_file.php "$HOME_DIR"/backups/"mysql_"$SUFFIX"_$BKPDATE".tar.gz
#/usr/bin/php "$HOME_DIR"/public_html/backup/upload_file.php "$HOME_DIR"/backups/"$USERNAME"_"$SUFFIX"_"$BKPDATE".tar.gz

#Remove old backups
#find "$HOME_DIR/backups" -type f -mtime +40 -exec rm {} \;