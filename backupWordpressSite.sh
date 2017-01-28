#!/bin/bash

function makeSQLBackup() {
    echo "> BACKING UP $1 LIVE DB";
    # Create backup folder and export db
    ssh $2@$3 -p $4 "mkdir -p $7/sql && wp db export - --path=$5 --allow-root | gzip > $7/sql/$1-$CURRENT_TIMESTAMP.sql.gz";
    echo ">> COMPLETED BACKING UP $1 LIVE DB";
    # echo "------- BACKING UP $1 TO BACKUP SERVER-------";
}

function makeFILEBackup() {
    echo "> BACKING SITES FOLDER FOR $1";
    # Create backup folder and export db
    ssh $2@$3 -p $4 "mkdir -p $7/files && zip -r -q $7/files/$1-$CURRENT_TIMESTAMP.zip $6";
    echo ">> COMPLETE BACKING UPLOADS FOLDER FOR $1";
}

function grabBackups() {
    echo "> SYNCING BACKUPS FOR $1";
    # Get files onto backup server
    rsync -e "ssh -p $4" -r --size-only $2@$3:$7/* $8/$1
    echo ">> COMPLETE SYNCING BACKUPS FOR $1";
}

function cleanupBackups() {
    echo "> CLEANING UP REMOTE BACKUPS FOR $1";
    # ssh $2@$3 -p $4 "find $7/* -mtime +2";
    # ssh $2@$3 -p $4 "find $7/* -mtime +2 -exec rm -rf {} \;";

    echo "> CLEANING UP LOCAL BACKUPS";
    # find $8/* -mtime +7
    # find $8/* -mtime +7 -exec rm -rf {} \;
}


# Usage: slackpost "<webhook_url>" "<channel>" "<message>"

# webhook_url=$1
# if [[ $webhook_url == "" ]]
# then
#         echo "No webhook_url specified"
#         exit 1
# fi
#
# shift
# channel=$1
# if [[ $channel == "" ]]
# then
#         echo "No channel specified"
#         exit 1
# fi
#
# shift
#
# text=$*
#
# if [[ $text == "" ]]
# then
#         echo "No text specified"
#         exit 1
# fi
#
# escapedText=$(echo $text | sed 's/"/\"/g' | sed "s/'/\'/g" )
# json="{\"channel\": \"$channel\", \"username\":\"backups\", \"text\": \"$escapedText\"}"
#
# curl -s -d "payload=$json" "$webhook_url"


# Set variables
CURRENT_TIMESTAMP="`date +%d-%m-%Y_%H-%M`"
CURRENT_DATE="`date +%d-%m-%Y`"


makeSQLBackup $1 $2 $3 $4 $5 $6 $7

makeFILEBackup $1 $2 $3 $4 $5 $6 $7

grabBackups $1 $2 $3 $4 $5 $6 $7

cleanupBackups $1 $2 $3 $4 $5 $6 $7
