
# Backup Directory Script

This script is designed to back up a specified directory to a designated backup location. It also includes options for error logging and deleting old backups.

## Features

- Backs up a specified source directory to a specified backup directory.
- Logs errors during the backup process to a log file.
- Optionally deletes backups older than 30 days.

## Prerequisites

- The script must be run as the root user.

## Usage

1. **Clone the repository or download the script:**

   ```bash
   git clone https://github.com/sakiphan/system-backup-directory-bash.git
   cd system-backup-directory-bash
   ```

2. **Make the script executable:**

   ```bash
   chmod +x backup_directory.sh
   ```

3. **Run the script manually:**

   ```bash
   sudo ./backup_directory.sh
   ```

   You will be prompted to enter the source directory and the backup directory. The script will then perform the backup and log any errors.

### Example

```
Enter the source directory to backup: /home/user
Enter the backup directory: /backup
Backing up directory: /home/user
Backup completed successfully: /backup/backup_YYYYMMDD_HHMMSS.tar.gz
Do you want to delete backups older than 30 days? (y/n): y
Old backups deleted.
Backup process completed.
```

## Automating with Cron

To run the script at regular intervals, create a cron job. For example, to run it every Sunday at 4 AM:

1. Edit the cron job file:

   ```bash
   sudo crontab -e
   ```

2. Add the following line to the file:

   ```bash
   0 4 * * 0 /path/to/backup_directory.sh
   ```

   Replace `/path/to/backup_directory.sh` with the full path to your script.

## Error Logging

If any errors occur during the backup process, they will be logged to a log file in the backup directory. The log file will be named `backup_errors_YYYYMMDD_HHMMSS.log`.

## Cleaning Up Old Backups

The script includes an option to delete backups older than 30 days. You will be prompted to confirm whether you want to delete old backups.
