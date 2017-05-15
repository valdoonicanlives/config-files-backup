#!/bin/bash

var="google:yahoo:microsoft:apple:oracle:hp:dell:toshiba:sun:redhat"


# Saving the original value of IFS
OLD_IFS=$IFS
IFS=:
echo "================="

for word in $var;do
        echo -e $word
done <<< $var

echo "================"

# Restore the value of IFS back to the script.
IFS=$OLD_IFS
