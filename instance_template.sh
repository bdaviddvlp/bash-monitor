#!/bin/bash

source .env
source config/bash-monitor.conf

name=$1
url=$2
while true; do
    # check internet connection
    if ! ping -q -c 1 -W 1 google.com &>/dev/null; then
        continue
    fi
    touch "response_$name"
    curl -sS -I -X HEAD --max-time $timeout $url &>"response_$name"
    has_timed_out=$(grep 'timed out' "response_$name" | wc -w)
    http_status=$(head -n 1 "response_$name" | awk '{print $2}')

    if [ -f "status_$name" ]; then
        if [ "$has_timed_out" -gt 0 ]; then
            continue
        fi

        echo "$http_status"
        if [ "$http_status" -eq 200 ]; then
            message="✅ For $name problem is resolved"
            curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" -d "chat_id=$TELEGRAM_ALERT_CHANNEL_ID" -d "text=$message"
            rm "status_$name"
        else
            continue
        fi
    fi

    if [ "$has_timed_out" -gt 0 ]; then
        touch "status_$name"
        message="⏳ HTTP request to $name timed out after 30 seconds"
        curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" -d "chat_id=$TELEGRAM_ALERT_CHANNEL_ID" -d "text=$message"
        continue
    fi

    # Check if the response code is not 200
    if [ "$http_status" != 200 ]; then
        touch "status_$name"

        # Message to send to Telegram
        message="❌ HTTP request to $name returned status code $http_status"

        # Send the message to Telegram using the Telegram Bot API
        curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" -d "chat_id=$TELEGRAM_ALERT_CHANNEL_ID" -d "text=$message"
    fi
    rm "response_$name"
    sleep $check_period
done
