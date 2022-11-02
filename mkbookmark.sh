#!/bin/sh

bookmark="$(xclip -o)"
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
if grep -q "^$bookmark$" "$file"; then
    notify-send "Oops." "Already bookmarked!"
else
    notify-send "Bookmark added!" "$bookmark"
    echo "$bookmark" >> "$file"
fi

