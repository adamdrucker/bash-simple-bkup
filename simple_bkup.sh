#!/bin/bash

# source ~/.bashrc
# Cron job set to run this script weekly on Tuesdays @ 12:00
# and on Thursdays @ 12:00
# Currently, being manually backed up to Google Drive
# --> Can now use `gupload` (Jan 2021)
# removed /etc/passwd from backup
# deprecating timeshift bits on new fedora laptop as timeshift caused a whole lot of fuckery and i am not doing it anymore (Apr 2023)

TODAY=$(date +%d-%m-%Y)

BACKUPDIR="/home/$USER/Backups/"
#SNAPSHOTDIR="/home/timeshift/snapshots/"
NEWEST=$(ls -t $BACKUPDIR | head -n +1)

# Count items in backup directory
COUNT=$(ls $BACKUPDIR -t | wc -l)

# Count items in snapshot dir
#SCOUNT=$(ls $SNAPSHOTDIR -t | wc -l)

# Create tarball from specified directories with exclusions
back_up_files() {
	tar -zc -X /home/adam/Documents/bash_scripts/simple_bkup/exclude.txt -f /home/$USER/Backups/"$TODAY"_backup.tar.gz /home/$USER 
}

# Clean up the backup dir
back_up_dir() {
	if [ $COUNT -eq "3" ]; then
		cd $BACKUPDIR
		ls -t $BACKUPDIR | grep tar.gz | tail -n +3 | xargs rm -f
	fi
}

# clean up the snapshot dir
# this needs sudo i think
#snap_clean() {
#	if [ $SCOUNT -gt "2" ]; then
#		cd $SNAPSHOTDIR
#		ls -t $SNAPSHOTDIR | tail -n +3 | xargs rm -rf
#	fi
#}

# Check the specified backup dir exists, if not, create it
test -d $BACKUPDIR
if [ $? == "1" ]; then
	mkdir "/home/$USER/Backups"
fi

back_up_files
back_up_dir
#snap_clean

#---------------------------------

#gupload $BACKUPDIR$NEWEST
