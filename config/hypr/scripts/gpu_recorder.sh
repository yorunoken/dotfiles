killall gpu-screen-recorder

# You may find this using `pactl get-default-sink`
default_output="alsa_output.pci-0000_0b_00.4.analog-stereo"

# You may find this using `pactl get-default-source`
default_input="alsa_input.pci-0000_0b_00.4.analog-stereo"

fps="60"
file_format="mp4"

# You may find these using `hyprctl monitors`
monitor_ids=("DP-1" "DP-2")
monitor_index="${1:-0}"

if ! [[ "$monitor_index" =~ ^[0-9]+$ ]]; then
    echo "Invalid monitor index. Please provide a valid number."
    exit 1
fi

if [ "$monitor_index" -ge "${#monitor_ids[@]}" ]; then
    echo "Invalid monitor index. Available indices: 0 to $((${#monitor_ids[@]} - 1))"
    exit 1
fi

sleep 1

gpu-screen-recorder -w "${monitor_ids[$monitor_index]}" -c $file_format -f $fps -a "$default_output.monitor|$default_input" -o ~/Videos/AMD -r 300 &
notify-send "GPU screen recorder" "Recording monitor: ${monitor_ids[$monitor_index]} at ${fps}fps"
