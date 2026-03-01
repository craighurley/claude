#!/usr/bin/env bash

# Sync configuration files to ~/.claude

# Start
echo "$(basename "$0") starting."

repo_dir="$(pwd)"

# # Create symlinks to ~/.claude
ln -sF "$repo_dir/agents" ~/.claude/agents
ln -sF "$repo_dir/commands" ~/.claude/commands
ln -sF "$repo_dir/hooks" ~/.claude/hooks
ln -sF "$repo_dir/rules" ~/.claude/rules
ln -sF "$repo_dir/skills" ~/.claude/skills
ln -sF "$repo_dir/CLAUDE.md" ~/.claude/CLAUDE.md
ln -sF "$repo_dir/settings.json" ~/.claude/settings.json

# Finished
echo "$(basename "$0") complete."
