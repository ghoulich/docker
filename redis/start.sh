#! /bin/bash

# Source function library.
. /etc/rc.d/init.d/functions

name="redis-server"
exec="/usr/bin/$name"
pidfile="/var/run/redis/redis.pid"
REDIS_CONFIG="/etc/redis/redis.conf"

[ -e /etc/sysconfig/redis ] && . /etc/sysconfig/redis

lockfile=/var/lock/subsys/redis

start() {
    [ -f $REDIS_CONFIG ] || exit 6
    [ -x $exec ] || exit 5
    echo -n $"Starting $name: "
    daemon --user ${REDIS_USER-redis} "$exec $REDIS_CONFIG --daemonize yes --pidfile $pidfile"
    retval=$?
    echo
    [ $retval -eq 0 ] && touch $lockfile
    return $retval
}

start

exit $?
