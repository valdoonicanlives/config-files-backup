#!/bin/bash


# Ctrl c to quit
# Selection menu items go here
SELECTION="weather leafpad option3 quit"

select options in $SELECTION; do

# here using the if statements you can perform the required  operation
if [ "$options" = "weather" ]; then
    chromium www.weer.nl

elif [ "$options" = "leafpad" ]; then
    leafpad

elif [ "$options" = "option3" ]; then
        echo "You have selected $options"

elif [ "$options" = "quit" ]; then
        echo "You have selected $options"
    exit

# if something else is selected, show the menu again
else
    clear;
    echo "please select some options"

fi
done
