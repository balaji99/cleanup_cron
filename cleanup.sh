#!/bin/bash

# Source the configuration file
source "./config.sh"

# Function to log messages
log_message() {    
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Main cleanup function
cleanup_directory() {
    # Get today's date using the configured format
    local today_date=$(date "$DATE_FORMAT")
        
    log_message "Today's date: $today_date"
    log_message "Storage status before cleanup: $(df -hT $PARENT_DIR)"
    log_message "Starting cleanup in: $PARENT_DIR"
    log_message "Preserving only the item named: \"$today_date\""
    
    # Change to the parent directory
    cd "$PARENT_DIR"
    if [ $? != 0 ]; then
        log_message "Failed to change to parent directory: $PARENT_DIR"
        exit 1
    fi
    
    # Delete everything that doesn't match today's date
    for item in *; do
        if [[ "$item" == "$today_date" ]]; then
            log_message "Preserving: $item"
        else
            log_message "Deleting: $item"
            rm -rf "$item"
        fi
    done
    
    log_message "Cleanup completed"
    log_message "Storage status after cleanup: $(df -hT $PARENT_DIR)"
}

main() {
    log_message "========================================"
    
    cleanup_directory
    
    log_message "========================================"
}

main &>> "$LOG_FILE"
