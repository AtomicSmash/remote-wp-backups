# Remote Wordpress backup via WP-CLI

This script is for backing up a live Wordpress website from a remote server. It doesn't require any wordpress plugins to be installed, but it does require:

1. Two distinct server environments on separate servers.
2. SSH access to both servers
3. Ability to be able to create a 'wp-backup' user on both servers

sudo adduser wp-backup

### How it works

It's pretty simple, the script (on your backup server) will SSH into your live server zip 

[image of server layout]

setup crontab with:

```
0 * * * * ~/dropbox-database-backup/backup.sh &> /dev/null
```




### Setup steps on live server

1. adduser wp-backup
1. mkdir -p ~/backups/files
1. mkdir -p ~/backups/sql



## Disclaimer
Even though we use this script on an daily across multiple servers we do enforce that you use this script at your own risk and we **are not responsible** for any detrimental effects that might occur from using. If you are unsure about what the script actually does or how it works, please do not use it without reviewing throughly.


## Notes

This script is Wordpress related but could easily
