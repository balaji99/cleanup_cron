#!/bin/bash

# Source the configuration file
source "./config.sh"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Now you can reference files relatively
if [ -x "config.sh" ]; then
    echo "Found config file"
    source "./config.sh"
else
    echo "Config file not found in $SCRIPT_DIR"
    exit 1
fi


# Function to log messages
log_message() {    
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Main cleanup function
cleanup_directory() {
    # Get today's date using the configured format
    local today_date=$(date "$DATE_FORMAT")
        
    log_message "Today's date: $today_date"
    log_message "Storage status before cleanup: $(df -hT $CLEANUP_ROOT_DIR )"
    log_message "Starting cleanup in: $CLEANUP_ROOT_DIR "
    log_message "Preserving only the item named: \"$today_date\""
    
    # Change to the parent directory
    cd "$CLEANUP_ROOT_DIR"
    if [ $? != 0 ]; then
        log_message "Failed to change to parent directory: $CLEANUP_ROOT_DIR "
        exit 1
    fi
    
    # Delete only items with dates in DATE_FORMAT (excluding today's date)
    for item in *; do
        if [[ "$item" == "$today_date" ]]; then
            log_message "Preserving today's item: $item"
        elif [[ "$(date -d "$item" "$DATE_FORMAT" 2>/dev/null)" == "$item" ]]; then
            log_message "Deleting old date item: $item"
            rm -rf "$item"
        else
            log_message "Preserving item: $item"
        fi
    done
    
    log_message "Cleanup completed"
    log_message "Storage status after cleanup: $(df -hT $CLEANUP_ROOT_DIR )"
}

main() {
    log_message "========================================"
    
    cleanup_directory
    
    log_message "========================================"
}

main &>> "$LOG_FILE"
