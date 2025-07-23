#!/bin/sh

LOG_TAG="WWAN-RESET"
LOCK_FILE="/var/run/wwan-reset.lock"

log() {
    logger -t "$LOG_TAG" "$1"
    echo "[$LOG_TAG] $1"
}

# Prevent double execution
if [ -e "$LOCK_FILE" ]; then
    log "Script already running. Exiting."
    exit 0
fi
touch "$LOCK_FILE"
trap "rm -f $LOCK_FILE" EXIT

check_iface_up() {
    ping -c 5 -W 3 8.8.8.8 > /dev/null 2>&1
    return $?
}

restart_iface() {
    log "Shutting down WAN interface..."
    ifdown wan
    sleep 60
    log "Starting WAN interface..."
    ifup wan
    sleep 30
}

main_loop() {
    log "Script started at system boot."
    log "Waiting 150 seconds for boot completion and interface initialization..."
    sleep 150

    log "Checking connectivity without touching WAN..."
    ATTEMPTS=0
    while ! check_iface_up; do
        ATTEMPTS=$((ATTEMPTS + 1))
        log "Attempt #$ATTEMPTS: ping failed. Rebooting system..."
        sleep 10
        reboot
        sleep 120
    done
    log "Internet active. Starting 3-hour reset cycle."

    while true; do
        sleep 10800  # 3 hours

        log "=== STARTING RESET CYCLE ==="
        restart_iface

        ATTEMPTS=0
        while ! check_iface_up; do
            ATTEMPTS=$((ATTEMPTS + 1))
            log "Attempt #$ATTEMPTS: ping failed after reset. Rebooting system..."
            sleep 10
            reboot
            sleep 120
        done

        log "Internet OK after reset. Next in 3 hours."
    done
}

main_loop &

exit 0
