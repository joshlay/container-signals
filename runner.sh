#!/bin/bash
#
# create our signal handler function
# this is where the work checking, delays, and clean up would take place
#
# the agent is *running* until it is killed during this process
function _signal_handler() {
	echo "signal trapped!"
	echo ""
	# could preserve exit codes from teardown steps here with $? after each
	echo "starting node teardown in two seconds"
	sleep 2
	echo "but... first, let's check on the agent after another short delay"
	sleep 2
	echo "  $(ps faux | grep 'n[c] -l')"
	sleep 2
	echo "hopefully you see it!"
	echo "all done!  exiting"
	# send the agent process a kill now that we're ready
	kill -TERM "$AGENT_PID" 2>/dev/null
	exit
}

# set the trap
trap _signal_handler SIGTERM SIGINT SIGQUIT SIGABRT
# trapping can be disabled at specific points like so:
# trap - SIGTERM SIGINT SIGQUIT SIGABRT
# the usage of '-' in place of the function disables the trap for the listed signals

# start the 'daemon' here, netcat listening
# it's tossed into the background with the PID recorded for 'waiting'
echo "starting daemon!"
nc -l &
# record the PID for the agent process handed off to the job controller
AGENT_PID=$!
# use wait to either wait for the job to finish, or signals to fire
wait "$AGENT_PID"

echo "this should *only* print after the process exits from an unhandled signal"
