#!/bin/bash

source config/bash-monitor.conf

running_processes=$(pgrep -f '_process.sh' | wc -l)
defined_processes=$(echo "$urls" | wc -l)

# send