#!/bin/bash

# check whether the env file exists
if [ ! -f .env ]; then
    echo 'Error: .env file not found. Create a .env file and try again.' >&2
    exit 1
fi

# check whether the config file exists
if [ ! -f config/bash-monitor.conf ]; then
    echo 'Error: config file not found. Create a config/bash-monitor.conf file and try again.' >&2
    exit 1
fi

# check whether the config file contains all properties
source config/bash-monitor.conf

if [ -z "$urls" ]; then
    echo 'Error: urls property not found in config/bash-monitor.conf file.' >&2
    exit 1
fi

if [ -z "$timeout" ]; then
    echo 'Error: timeout property not found in config/bash-monitor.conf file.' >&2
    exit 1
fi

if [ -z "$check_period" ]; then
    echo 'Error: check_period property not found in config/bash-monitor.conf file.' >&2
    exit 1
fi

# check whether urls parameter is valid
if [[ "$urls" != *","* ]]; then
    echo 'Error: urls property must be a comma-separated list of names and URLs. Example: example1,example1.com' >&2
    exit 1
fi

# check whether timeout parameter is valid
if ! [[ "$timeout" =~ ^[0-9]+$ ]]; then
    echo 'Error: timeout property must be an integer. Example: 30' >&2
    exit 1
fi

# check whether check_period parameter is valid
if ! [[ "$check_period" =~ ^[0-9]+$ ]]; then
    echo 'Error: check_period property must be an integer. Example: 60' >&2
    exit 1
fi

# check whether curl is installed
if ! [ -x "$(command -v curl)" ]; then
    echo 'Error: curl is not installed. Please install curl and try again.' >&2
    exit 1
fi

# delete existing process scripts before running the watchers
rm *_process.sh

# run the url watchers script
./run_url_watchers.sh
echo 'All processes have been started.'

echo 'To stop the url watchers, run the kill_monitor.sh script.'