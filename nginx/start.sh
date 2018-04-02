#! /bin/bash

# Source function library.
. /etc/rc.d/init.d/functions

if [ -L $0 ]; then
    initscript=`/bin/readlink -f $0`
else
    initscript=$0
fi

sysconfig=`/bin/basename $initscript`

if [ -f /etc/sysconfig/$sysconfig ]; then
    . /etc/sysconfig/$sysconfig
fi

nginx=${NGINX:-/usr/sbin/nginx}
prog=`/bin/basename $nginx`
conffile=${CONFFILE:-/etc/nginx/nginx.conf}
lockfile=${LOCKFILE:-/var/lock/subsys/nginx}
pidfile=${PIDFILE:-/var/run/nginx.pid}
SLEEPSEC=${SLEEPSEC:-1}
UPGRADEWAITLOOPS=${UPGRADEWAITLOOPS:-5}
CHECKSLEEP=${CHECKSLEEP:-3}
RETVAL=0

start() {
    echo -n $"Starting $prog: "

    daemon --pidfile=${pidfile} ${nginx} -c ${conffile}
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && touch ${lockfile}
    return $RETVAL
}

start

exit $RETVAL
