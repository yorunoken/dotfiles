#!/usr/bin/env sh

base_brightness=44

function print_error
{
cat << "EOF"
    ./brightnesscontrol.sh <action>
    ...valid actions are...
        w -- <w>ake, sets brightness to the constant.
        s -- <s>leep, decreases the brightness to the minimum.
EOF
}

function get_monitors {
    ddcutil detect | grep 'I2C bus:' | awk -F'i2c-' '{print $2}' | awk '{print $1}'
}
function set_brightness {
    local brightness=$1
    local bus

    for bus in $(get_monitors); do
        echo "Setting brightness to $brightness for monitor on bus $bus"
        ddcutil --bus=$bus setvcp 10 $brightness
    done
}

case $1 in
w)  # Wake up
    echo "Setting brightness to $base_brightness for all monitors"
    set_brightness $base_brightness
    ;;
s)  # Go to sleep
    echo "Setting brightness to 0 for all monitors"
    set_brightness 0
    ;;
*)  # Print error
    print_error ;;
esac
