#!/bin/bash

source config/bash-monitor.conf

# show started processes by init_monitor.sh
ps -eo pid,user,command | grep '_process.sh' | grep -v grep | awk '{printf "%-8s %-15s %-15s %s\n", $1, $2, $4, $6}'