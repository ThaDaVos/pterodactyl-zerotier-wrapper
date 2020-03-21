#!/bin/sh

export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin

# zerotier-one & export APP_PID=$!
# sleep 5

# for ID in $(echo $NETWORK_ID | tr "," "\n")
# do
#     zerotier-cli join $ID
# done

# runuser -l container -c "exec $@"
exec gosu container "$@"