#!/bin/sh

TARGETFILE="$HOME/.targetfile"
cat "/dev/null" > "$TARGETFILE"
ranger $BOOKMARKS_ROOT --choosedir=$TARGETFILE --show-only-dirs
wait $BACK_PID

folder="$(cat $TARGETFILE)"

if test -z "$folder"; then
    notify-send "No folder was provided!"
    exit 1
fi

file="$folder/bookmarks"
cat "/dev/null" >> "$file"
xdotool type $(grep -v '^#' $file | dmenu -i -l 50 | cut -d' ' -f1)
