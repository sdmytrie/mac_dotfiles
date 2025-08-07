#!/bin/bash

sketchybar --add item wifi right \
    --set wifi icon="􁓣" \
    script="$PLUGIN_DIR/wifi.sh" \
    --subscribe wifi wifi_change
