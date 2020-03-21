#!/bin/sh

echo "After entrypoint I'll execute '$@'"

if ! [ $(id -u) = 0 ]; then
    echo "User is non-root | So I can't run Zerotier"
    exec "$@"
else
    echo "User is root, going to start Zerotier in the background"

    export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin
    file="/home/container/zerotier"

    if [ ! -f "$file" ]; then
        echo "No Zerotier file found at $file"
    else
        echo "Found zerotier file at $file"
        zerotier-one &
        export APP_PID=$!
        echo "Zerotier starting..."
        sleep 5
        echo "Zerotier started - going to join networks mentioned in $file"
        while read id; do
            zerotier-cli join $id
        done <"$file"
        echo "See log above if joining was succesful"
    fi

    exec gosu container "$@"
fi
