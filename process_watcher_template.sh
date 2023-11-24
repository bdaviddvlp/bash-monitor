#!/bin/bash

name=$1

# check whether process with name exists
if pgrep -x "$name_process_watcher_process.sh" > /dev/null
then
    echo "Process $name is running"
else
    echo "Process $name is not running"
fi