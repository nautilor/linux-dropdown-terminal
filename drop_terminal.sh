#!/usr/bin/env sh

#::::::::: VARIABLES ::::::::::::::
# Good for accessibility to have a the
# possibility to view and edit the two
# variables below
term="kitty"

#::::::::: FUNCTIONS ::::::::::::::

function help {
    echo -e "USAGE\n=====\n- $0"
    echo -e "  - show    > show the dropdown terminal"
    echo -e "  - hide    > hide the dropdown terminal"
    echo -e "  - toggle  > toggle the view of the dropdown terminal"
    exit
}

# Check AND if its running and the status
   # If the status function fails, it echo 2, it means than
   # the WID is not found, so than the terminal is not running
   # so as we want to show it, it spawns it...

function status {
	[ -z "$WID" ] && spawn && return

    winfos=`xwininfo -id $WID -stats 2>/dev/null`
    [ -z "$winfos" ] && echo 2 && return

    state=`grep IsUnMapped <<< $winfos`
    [ -n "$state" ] && echo 0 || echo 1
}

# spawn a new one if needeed
function spawn {
    $term --class drop_terminal &
    pid=$!
    sleep 0.5
    # More secure to grep the pid
    WID=`wmctrl -lxp | grep $pid | grep -v "grep" | awk '{print $1}'`
    echo "$WID" > $SCRATCH
}

# hide the dropdown terminal
function hide {
	 WID=`head -n 1 $SCRATCH 2>/dev/null`
	 [ -z "$WID" ] && exit
	 [ `status` -eq 1 ] && xdo hide $WID
    exit
}

# show the dropdown terminal
function show {
	 WID=`head -n 1 $SCRATCH 2>/dev/null`
	 if [ `status` -eq 0 ]; then
	 	  xdo show $WID
	 	  xdo activate $WID
	 elif [ `status` -eq 2 ]; then
	 	  spawn
	 fi
    exit
}

function toggle {
	 WID=`head -n 1 $SCRATCH 2>/dev/null`
	 if [ `status` -eq 2 ]; then
	 	  spawn
	 elif [ `status` -eq 1 ]; then
        hide
    else
        show
    fi
}

#:::::::::: SCRIPT :::::::::::::::::

SCRATCH="$HOME/.drop_terminal"

[ $# -eq 0 ] && help
[ "$1" = "hide" ] && hide
[ "$1" = "show" ] && show
[ "$1" = "toggle" ] && toggle