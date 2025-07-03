Here's how to create a cron job that runs at 12 AM daily:

## Store the cleanup script on your server, and make sure it has execute permissions
`chmod +x /path_to_your_script/cleanup.sh`

## Configure the cron job

1. Open your terminal and edit your cron table:
```bash
crontab -e
```

2. Add this line to schedule a job at 12:00 AM daily:
```bash
0 0 * * * /path_to_your_script/cleanup.sh
```

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
