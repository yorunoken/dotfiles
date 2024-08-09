kill $(pgrep -f gpu-screen-recorder)

# You may find this using `pactl get-default-sink`
default_output="alsa_output.pci-0000_0b_00.4.analog-stereo"

# You may find this using `pactl get-default-source`
default_input="alsa_input.pci-0000_0b_00.4.analog-stereo"

gpu-screen-recorder -w DP-2 -c mp4 -f 60 -a "$default_output.monitor|$default_input" -o ~/Videos/AMD -r 300 &
