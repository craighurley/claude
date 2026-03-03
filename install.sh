#!/usr/bin/env bash

# Start
echo "$(basename "$0") starting."

# Install/update go packages
echo "go packages..."
go install github.com/sammcj/mcp-devtools@HEAD
go install github.com/sammcj/run_silent@HEAD
go install golang.org/x/tools/gopls@latest

# Install/update npm
echo "npm..."
npm install -g npm
npm install -g --omit=dev pyright
npm install -g --omit=dev typescript-language-server typescript

# Update claude
echo "Update claude..."
claude update

# Install/update claude code plugins
echo "claude plugins..."
claude plugin marketplace update claude-plugins-official
claude plugin install claude-md-management
claude plugin install code-review
claude plugin install code-simplifier
claude plugin install gopls-lsp
claude plugin install pyright-lsp
claude plugin install skill-creator
claude plugin install superpowers
claude plugin install swift-lsp
claude plugin install typescript-lsp

# Add MCP servers
echo "claude MCP servers..."
claude mcp add --transport http --scope user excalidraw https://mcp.excalidraw.com
claude mcp add --transport stdio --scope user mcp-devtools --env ENABLE_ADDITIONAL_TOOLS="aws_documentation,code_skim,excel,murican_to_english,process_document,terraform_documentation" -- $HOME/go/bin/mcp-devtools

# TODO: validate
# Context management: https://github.com/mksglu/claude-context-mode
#claude mcp add context-mode -- npx -y context-mode

# Finished
echo "$(basename "$0") complete."
