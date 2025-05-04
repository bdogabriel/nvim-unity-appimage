#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/nvim-unity"
CONFIG_FILE="$CONFIG_DIR/config.json"
NVIM_PATH="nvim"
SOCKET="~/.cache/nvimunity.sock"

mkdir -p "$CONFIG_DIR"

if [ ! -f "$CONFIG_FILE" ]; then
	echo '{"last_project": ""}' >"$CONFIG_FILE"
fi

LAST_PROJECT=$(jq -r '.last_project' "$CONFIG_FILE")

FILE="$1"
LINE="${2:-1}"

if ! [[ "$LINE" =~ ^[1-9][0-9]*$ ]]; then
	LINE="1"
fi

SHIFT_PRESSED=false
if command -v xdotool >/dev/null; then
	xdotool keydown Shift_L keyup Shift_L >/dev/null 2>&1 && SHIFT_PRESSED=true
fi

if [ "$SHIFT_PRESSED" = true ] && [ -n "$LAST_PROJECT" ]; then
	CMD="$NVIM_PATH --listen $SOCKET \"+$LINE\" \"+cd \"$LAST_PROJECT\"\" $FILE"
else
	CMD="$NVIM_PATH --listen $SOCKET \"+$LINE\" $FILE"
fi

eval "$CMD"
