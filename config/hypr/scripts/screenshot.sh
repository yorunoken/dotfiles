mode="$1"
screenshotPath = ~/Pictures/Screenshots

hyprpicker -r -z &

hyprpicker_pid=$!

sleep 0.1

hyprshot -m $mode -o $screenshotPath

hyprshot_pid=$!
wait $hyprshot_pid

sleep 0.1

kill $hyprpicker_pid
kill $hyprshot_pid