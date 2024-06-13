#!/bin/bash

# Ensure the script is being run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Prompt the user to input the source directory and backup directory
read -p "Enter the source directory to backup: " SOURCE_DIR
read -p "Enter the backup directory: " BACKUP_DIR

# Verify the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory does not exist: $SOURCE_DIR"
  exit 1
fi

# Set timestamp and backup file name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Create the backup directory if it does not exist
mkdir -p $BACKUP_DIR

# Define the log file for errors
LOG_FILE="$BACKUP_DIR/backup_errors_$TIMESTAMP.log"

# Execute the backup
echo "Backing up directory: $SOURCE_DIR"
if tar -czf $BACKUP_FILE $SOURCE_DIR 2> $LOG_FILE; then
  echo "Backup completed successfully: $BACKUP_FILE"
else
  echo "Backup failed. Check the log file for details: $LOG_FILE"
  exit 1
fi

# Ask the user if they want to delete backups older than 30 days
read -p "Do you want to delete backups older than 30 days? (y/n): " DELETE_OLD
if [ "$DELETE_OLD" == "y" ]; then
  find $BACKUP_DIR -type f -name "backup_*.tar.gz" -mtime +30 -exec rm -f {} \;
  echo "Old backups deleted."
fi

echo "Backup process completed."
