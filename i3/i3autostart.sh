###
## Set keyboard settings - 250 ms delay and 25 cps (characters per second) repeat rate.
## Adjust the values according to your preferances.
xset r rate 250 25 &

# Temporarily disable pointer while setting layout
# $1 == <enable|disable>
pointer_control() {
	[ -v pointer_devices ] || pointer_devices=$(xinput --list \
		| sed -nr '/Virtual\score.*pointer/ !s/.*id=([0-9]+)\s+\[slave\s+pointer.*/\1/p')
	for dev in $pointer_devices; do xinput --$1 $dev; done
}

# Wait for the last command sent to background to create a window
wait_for_program () {
	local c=0; until [ $((++c)) -eq 15 ]; do
		xdotool search --onlyvisible --pid $! 2>/dev/null && break
		sleep 1
    done
	[ $c -eq 15 ] && i3-nagbar -m "Error on executing $0 script"
}

# /home/dka/bin/urxvtc -name urxvtq -e /home/dka/bin/start-tmux &
/home/dka/bin/urxvtc -name urxvtq -geometry 140x34 -e /home/dka/bin/start-tmux &
sleep 1
devilspie -a &
sleep 6
conky &
exit

