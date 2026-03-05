#!/usr/bin/env bash
set -euo pipefail

# Read all of stdin into a variable
input=$(cat)

# Extract fields with jq, "// 0" provides fallback for null
model=$(echo "$input" | jq -r '.model.display_name')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
dir=$(echo "$input" | jq -r '.workspace.current_dir')

green=$'\033[0;32m'
orange=$'\033[38;5;208m'
bright_white=$'\033[1;97m'
reset=$'\033[0m'

model="${orange}${model}${reset}"
dir="${bright_white}${dir/#$HOME/\~}${reset}"

if git rev-parse --git-dir > /dev/null 2>&1; then
    branch="${green}$(git branch --show-current 2>/dev/null)${reset} |"
else
    branch=""
fi

echo "$model | $pct% | $branch $dir"
