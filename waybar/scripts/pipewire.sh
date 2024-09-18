#!/bin/bash

volume_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

# Extract the volume percentage using sed and perl
volume=$(echo "$volume_info" | sed 's/Volume: //' | xargs -I {} bash -c 'perl -e "print {} * 100"')

# Check if it's muted
if echo "$volume_info" | grep -q "MUTED"; then
    echo "MUTE"
else
    # Display volume with appropriate icon based on volume level
    if (( $(perl -e "print $volume > 50 ? 1 : 0") )); then
        echo " $volume%"
    elif (( $(perl -e "print $volume > 25 ? 1 : 0") )); then
        echo " $volume%"
    elif (( $(perl -e "print $volume > 0 ? 1 : 0") )); then
        echo " $volume%"
    else
        echo "MUTE"
    fi
fi
