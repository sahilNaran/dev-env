#!/bin/bash

# AeroSpace workspace indicator for SwiftBar
# Shows workspaces in keyboard order with active one in parentheses

# Get current focused workspace
FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null)

# Build output - keyboard order: 1 2 3 4 5 6 7 8 9 0
OUTPUT="[ "
for i in 1 2 3 4 5 6 7 8 9 0; do
    if [ "$i" = "$FOCUSED" ]; then
        # Active workspace - in parentheses
        OUTPUT="${OUTPUT}(${i}) "
    else
        # Inactive workspace
        OUTPUT="${OUTPUT}${i} "
    fi
done
OUTPUT="${OUTPUT}]"

echo "$OUTPUT| font=SF Mono size=12 bgcolor=#3C3C3C color=#FFFFFF"
echo "---"
echo "Active Workspace: $FOCUSED"
echo "---"
for i in 1 2 3 4 5 6 7 8 9 0; do
    if [ "$i" = "$FOCUSED" ]; then
        echo "✓ Workspace $i | color=#1DB954"
    else
        echo "  Workspace $i | bash=/opt/homebrew/bin/aerospace param1=workspace param2=$i terminal=false refresh=true"
    fi
done
