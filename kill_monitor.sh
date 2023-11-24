#!/bin/bash

# Get the list of process IDs for all running *_process.sh processes
process_ids=$(pgrep -f '_process.sh')

# Check if any process IDs were found
if [ -n "$process_ids" ]; then
    # Kill each process
    for pid in $process_ids; do
        kill $pid
    done
    rm *_process.sh 2>&1 >/dev/null
    rm status* 2>&1 >/dev/null
    rm response* 2>&1 >/dev/null
    rm nohup.out 2>&1 >/dev/null
    echo "All running monitoring processes have been killed."
else
    echo "No running monitoring processes found."
fi