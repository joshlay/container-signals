#!/bin/bash
#
# create our signal handler function
# this is where the work checking, delays, and clean up would take place
function _signal_handler() {
	echo "signal trapped!"
	echo ""
	# could preserve exit codes from teardown steps here with $? after each
	echo "starting node teardown"
#	sleep 2
	echo "done!  exiting"
	exit
}

echo "starting daemon!"
# wait/sleep for signals (for a day)
# start by setting traps for signals
# calls handler function with the signal as an argument
# note: cannot intercept sigkill
#
trap _signal_handler SIGTERM SIGINT SIGQUIT SIGABRT
# trapping can be disabled at specific points like so:
# trap - SIGTERM SIGINT SIGQUIT SIGABRT
# the usage of '-' in place of the function disables the trap for the listed signals
#
# mock agent/daemon command
nc -l
echo "this should *only* print after a day"
echo "... if the process hasn't received/handled a terminating signal"
