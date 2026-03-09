#!/usr/bin/env bash
set -euo pipefail

# Read all of stdin into a variable
input=$(cat)

green=$'\033[0;32m'
orange=$'\033[38;5;208m'
red=$'\033[0;31m'
white=$'\033[0;97m'
bright_white=$'\033[1;97m'
reset=$'\033[0m'

# Extract fields with jq, "// 0" provides fallback for null
model="${orange}$(echo "$input" | jq -r '.model.display_name')${reset}"
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
dir=$(echo "$input" | jq -r '.workspace.current_dir')
dir="${bright_white}${dir/#$HOME/\~}${reset}"

if git rev-parse --git-dir > /dev/null 2>&1; then
    git_info="${green}$(git branch --show-current 2>/dev/null)${reset} "

    deleted=$(git ls-files --deleted 2>/dev/null | wc -l | tr -d ' ')
    modified=$(git diff --diff-filter=M --numstat 2>/dev/null | wc -l | tr -d ' ')
    staged=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
    upstream=$(git rev-parse --abbrev-ref "@{u}" 2>/dev/null || echo "")
    ahead=$(git rev-list --count "@{u}..HEAD" 2>/dev/null || echo 0)
    behind=$(git rev-list --count "HEAD..@{u}" 2>/dev/null || echo 0)

    [ "$deleted" -gt 0 ] && git_info="${git_info}${red}x${reset}"
    [ "$modified" -gt 0 ] && git_info="${git_info}${red}*${reset}"
    [ "$staged" -gt 0 ] && git_info="${git_info}${red}+${reset}"
    [ "$untracked" -gt 0 ] && git_info="${git_info}${red}?${reset}"
    [ "$ahead" -gt 0 ] && git_info="${git_info}${red}⇡${reset}"
    [ "$behind" -gt 0 ] && git_info="${git_info}${red}⇣${reset}"
    [ -n "$upstream" ] && [ "$ahead" -eq 0 ] && [ "$behind" -eq 0 ] && git_info="${git_info}${white}=${reset}"

    git_info="${git_info} | "
else
    git_info=""
fi

echo "$model | $pct% | $git_info$dir"
