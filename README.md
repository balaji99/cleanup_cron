# What this tool does
When the tool is run, it scans the CLEANUP_ROOT_DIR folder 

Files and folders with such names are preserved:
- Today's date in the DATE_FORMAT format.
- Any date which is not in DATE_FORMAT format.
- Anything which is not a date

Files and folders with such names are deleted:
- A date in the DATE_FORMAT format excluding today's date.

# How to install and use this tool

## Store the cleanup and config scripts on your server. They must be stored in the same location.

## Modify the variables in the config script

### CLEANUP_ROOT_DIR
Set this to the parent directory path where cleanup operations will be performed.

### DATE_FORMAT
Set this to the date format used to match folder/file names (follows date command format).

### LOG_FILE
Set this to the filename that will store the script logs.

## Make sure both the scripts have read and execute permissions.
`
chmod +rx /path_to_your_script/cleanup.sh /path_to_your_script/config.sh
`

## Configure the cron job

1. Open your terminal and edit your cron table:
```bash
crontab -e
```

2. Add this line to schedule a job at 12:00 AM daily:
```bash
0 0 * * * /path_to_your_script/cleanup.sh
```

You can choose to set your own schedule to decide when or how often the tool runs.


3. Save and exit the editor

## Verify your cron job

Check if your cron job is scheduled:
```bash
crontab -l
```

Check if cron service is running:
```bash
systemctl status cron
```

The job will now execute every day at exactly 12:00 AM (midnight). 
