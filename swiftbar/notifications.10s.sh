#!/bin/bash

# Notification badges for Outlook, Teams, and Slack
# Displays badge counts in menu bar with SF Symbols icons

# Function to get badge count for an app using lsappinfo
get_badge() {
    local bundle_id="$1"

    # Get PID for the app
    local pid=$(pgrep -f "$bundle_id" | head -1)

    if [ -z "$pid" ]; then
        echo "0"
        return
    fi

    # Get badge label using lsappinfo
    local badge=$(lsappinfo info -only StatusLabel "$pid" 2>/dev/null | grep -o '"label"="[^"]*"' | cut -d'"' -f4)

    if [ -z "$badge" ]; then
        echo "0"
    else
        echo "$badge"
    fi
}

# Get badge counts using bundle IDs
OUTLOOK=$(get_badge "Microsoft Outlook")
TEAMS=$(get_badge "Microsoft Teams")
SLACK=$(get_badge "Slack")

# Build output with SF Symbols icons and numbers
OUTPUT=""
if [ $OUTLOOK -gt 0 ]; then
    OUTPUT="${OUTPUT}:envelope.fill: ${OUTLOOK} "
fi
if [ $TEAMS -gt 0 ]; then
    OUTPUT="${OUTPUT}:person.2.fill: ${TEAMS} "
fi
if [ $SLACK -gt 0 ]; then
    OUTPUT="${OUTPUT}:bubble.left.fill: ${SLACK} "
fi

# Show output or a checkmark if no notifications
if [ -z "$OUTPUT" ]; then
    echo "✓"
else
    echo "$OUTPUT"
fi

echo "---"
echo "📧 Outlook: $OUTLOOK | color=#0078D4"
echo "💼 Teams: $TEAMS | color=#6264A7"
echo "💬 Slack: $SLACK | color=#4A154B"
echo "---"
echo "Refresh | refresh=true"
