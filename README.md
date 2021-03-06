# Remote Wordpress backups

**These docs are currently being edited**

## PLEASE READ THE DISCLAIMER BEFORE USING

This script is for backing up a live Wordpress websites from a remote server. It doesn't require any wordpress plugins to be installed, but it does require:

1. Two distinct server environments on separate servers.
1. SSH access to both servers
1. Ability to be able to create a 'wp-backup' user on both servers
1. wp-cli needs to be installed on the live for database backups

## How it works

The script (on your backup server) will SSH into your live server and zip up image and take a backup of the current database.

[image of server layout]

setup crontab with:



### Initial setup on BACKUP server

1. Add new 'wp-backup'
1. Switch to new user
1. Clone this project to the home directory of 'wp-backup'
1. Make a 'backups' folder, also in the home directory of the 'wp-backup' user

All this can be achieved by running these commands

### Initial setup on LIVE server



### Starting backups

The 4 paramters passed into backupWordpressSite.sh are:

1. Site name (for logging and display purposes)
1. Remote - username
1. Remote - address
1. Remote - port
1. Remote - Wordpress directory
1. Remote - Wordpress uploads directory
1. Remote - Backup directory
1. Local - Backup directory

```
0 2 * * * ~/remote-wp-backups/backupWordpressSite.sh SITENAME USERNAME ADDRESS PORT WP-DIR UPLOADS-DIR LOCAL-DIR &> /dev/null
```



## Notes
This script is Wordpress focussed but could easily be made CMS agnostic by removing the wp-cli commands for grabbing the live database.

## Disclaimer
Even though we use this script on an daily across multiple servers by multiple users, we do enforce that you use this script at your own risk and we **are not responsible** for any detrimental effects that might occur from using. If you are unsure about what the script actually does or how it works, **please do not use it without reviewing throughly**.

##Thanks
Slack integration taken from https://gist.github.com/dopiaza/6449505
