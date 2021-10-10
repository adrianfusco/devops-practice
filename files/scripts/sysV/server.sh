#!/bin/bash

function start() {
    export FLASK_APP=/app.py
	flask run
}

case "$1" in
	start)
		start
		;;
	stop)
		echo "System is shutting down"
		sleep 2
		;;
	status)
		echo "Everything looks good"
		;;
	*)
		echo "Usage: $0 {start|stop|status}"
		exit 5
esac
exit $?
