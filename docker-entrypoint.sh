#!/bin/sh
set -e

DATA_DIR="/var/opt/thelounge"
CONFIG_FILE="$DATA_DIR/config.js"
DEFAULT_CONFIG="/defaults/config.js"

# Create data directory if it doesn't exist
mkdir -p "$DATA_DIR/users"

# Only copy default config if no config exists
# This preserves user settings across container restarts
if [ ! -f "$CONFIG_FILE" ]; then
    echo "No config found, copying default config..."
    cp "$DEFAULT_CONFIG" "$CONFIG_FILE"
fi

# Create default user if no users exist
if [ -z "$(ls -A $DATA_DIR/users 2>/dev/null)" ]; then
    echo "No users found, creating default user 'socket'..."
    thelounge add socket --password test123 --save-logs || true
fi

# Fix permissions
chown -R node:node "$DATA_DIR"

# Start The Lounge
exec thelounge start
