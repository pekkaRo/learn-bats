#!/usr/bin/env bash

FIRST_RUN_FILE=/tmp/bats-tutorial-project-ran

if [[ ! -e $FIRST_RUN_FILE ]]; then
  echo "Welcome to our project!"
  touch $FIRST_RUN_FILE
fi

_stop_echo_server() {
     if [ -f /tmp/project-echo-server.pid ]; then
        echo "Stopping echo server"
        kill $(cat /tmp/project-echo-server.pid)
        rm /tmp/project-echo-server.pid
    else
        echo "Echo server is not running"
    fi
}

_start_echo_server() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        ncat -l $PORT -k -c 'xargs -n1 -r echo' 2>/dev/null &
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        nc localhost -lk $PORT -c 'xargs -n1 -r echo' >/dev/null 2>&1 &
    else
        echo "NOT IMPLEMENTED!" >&2
        exit 1
    fi
}

case $1 in
    start-echo-server)
        echo "Starting echo server"
        PORT=2000
        _start_echo_server
        echo $! > /tmp/project-echo-server.pid || true
        echo "$PORT" >&2
    ;;
    stop-echo-server)
        _stop_echo_server
    ;;
    *)
        echo "NOT IMPLEMENTED!" >&2
        exit 1
    ;;
esac