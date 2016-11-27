#!/bin/bash

function makeSQLBackup() {
    echo "------- BACKING UP $1 LIVE DB -------";
    # Create backup folder and export db
    ssh $2@$3 -p $4 "mkdir -p $6/sql && wp db export - --path=$5 --allow-root | gzip > $6/sql/$1-$CURRENT_TIMESTAMP.sql.gz";
    echo "------- COMPLETED BACKING UP $1 LIVE DB -------";
    # echo "------- BACKING UP $1 TO BACKUP SERVER-------";
}

function makeFILEBackup() {
    echo "------- BACKING SITES FOLDER FOR $1 -------";
    # Create backup folder and export db
    ssh $2@$3 -p $4 "mkdir -p $6/files && zip -r -q $6/files/$1-$CURRENT_DATE.zip $5";
    echo "------- COMPLETE BACKING UPLOADS FOLDER FOR $1 -------";
}

function grabBackups() {
    echo "------- SYNCING BACKUPS FOR $1 -------";
    # Get files onto backup server
    rsync -e "ssh -p $4" -r --size-only $2@$3:$6/* $6/$1
    echo "------- COMPLETE SYNCING BACKUPS FOR $1 -------";
}

function cleanupBackups() {

    # find ~/Music/* -mtime +5 -exec ls \;


    # ssh $2@$3 -p $4 "find $6/* -mtime +20";

    # Remove backups older than 2 days form the live server
    # ssh $2@$3 -p $4 "find $6/* -mtime +2 -exec rm -rf {} \;";

    # Remove backups from backup server
    # find $6/* -mtime +2 -exec rm -rf {} \;
    # find $6/* -mtime +2

}

# Set variables
CURRENT_TIMESTAMP="`date +%d-%m-%Y_%H-%M`"
CURRENT_DATE="`date +%d-%m-%Y`"


makeSQLBackup $1 $2 $3 $4 $5 $6

makeFILEBackup $1 $2 $3 $4 $5 $6

grabBackups $1 $2 $3 $4 $5 $6

# cleanupBackups $1 $2 $3 $4 $5 $6
