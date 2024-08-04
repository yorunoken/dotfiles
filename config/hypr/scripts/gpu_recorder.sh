kill $(pgrep -f gpu-screen-recorder)

gpu-screen-recorder -w DP-2 -c mp4 -f 60 -a "$(pactl get-default-sink).monitor|$(pactl get-default-source)" -o ~/Videos/AMD -r 300 &
