#!/bin/bash

# Set to 1 is you want to use dmenurc instead of reading from the Xresources
# database database (patched dmenu only (like dmenu2))
USE_DMENURC=0
USE_VERTICAL=1

MenuProg=""
promptOption=""
BACKEND=${1:-dmenu}

case "${BACKEND}" in
    'fzf')
        MenuProg="fzf --print-query"
        promptOption="--prompt"
        ;;
    'dmenu')
        if [[ $USE_DMENURC == 1 ]]; then
            # $MENU_DIR should be set in parent script...
            source $MENU_DIR/lib/dmenurc
        else
            if [[ $USE_VERTICAL == 1 ]]; then
                DMENU="dmenu -i -l 12 -x 403 -y 200 -w 560"
            else
                DMENU="dmenu -i"
            fi
        fi

        # Dmenu2 implements the '-s' option which allows us to choose which
        # monitor to open our menu on.
        MenuProg="$DMENU -s 0 "

        # MenuProg="$DMENU"

        promptOption="-p"
        ;;
    'rofi')
        MenuProg="rofi -dmenu"
        promptOption="-p"
        ;;
esac

###################
## Functions
###################

function join
{
    local IFS="$1"
    shift
    echo "$*"
}

function menu
{
    # Grab the prompt message.
    local prompt="$1"
    shift

    # Combine the rest of our arguments.
    local items=$(join $'\n' "$@")

    $MenuProg $promptOption "${prompt}" <<< "${items}" | tail -1
}

# We can use menu() function for yes/no prompts.
function confirm
{
    menu "$*" 'No' 'Yes'
}

# And we can even use it for a simple notice.
function alert
{
    menu "$*" 'OK'
}