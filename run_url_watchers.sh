#!/bin/bash

source config/bash-monitor.conf

# Read the names ans URLs from the file to targets array
IFS=$'\n' read -d '' -r -a targets <<<"$urls"

for target in "${targets[@]}"; do
    IFS=',' read -ra properties <<<"$target"
    echo "Running ${properties[0]}_process.sh"
    cp instance_template.sh "${properties[0]}_process.sh"
    chmod +x "${properties[0]}_process.sh"
    nohup ./"${properties[0]}_process.sh" "${properties[0]}" "${properties[1]}" &
done
