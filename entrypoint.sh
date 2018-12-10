#!/bin/sh

# Start the ssh server
/etc/init.d/ssh start && /sbin/my_init


# Execute the CMD
# exec "$@"