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

case $1 in
    start-echo-server)
        echo "Starting echo server"
        PORT=2000
        nohup nc localhost -lk $PORT -c 'xargs -n1 -r echo' >/dev/null 2>&1 &
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