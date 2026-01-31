#!/bin/bash

# Skiil Universal Installer
# Usage: ./scripts/install.sh <skill-name> <target>

SKILL_NAME=$1
TARGET=$2

if [ -z "$SKILL_NAME" ] || [ -z "$TARGET" ]; then
    echo "Usage: ./scripts/install.sh <skill-name> <target>"
    echo "Targets: cursor-local, cursor-global, vscode, mcp, print"
    exit 1
fi

SOURCE_DIR="$(pwd)/skills/$SKILL_NAME"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Skill '$SKILL_NAME' not found in skills/ directory."
    exit 1
fi

case $TARGET in
    "cursor-local")
        DEST_DIR="$(pwd)/.cursor/skills/$SKILL_NAME"
        mkdir -p "$(pwd)/.cursor/skills"
        ln -sfn "$SOURCE_DIR" "$DEST_DIR"
        echo "✅ Installed '$SKILL_NAME' to Cursor (Local project)"
        ;;
    "cursor-global")
        DEST_DIR="$HOME/.cursor/skills-cursor/$SKILL_NAME"
        mkdir -p "$HOME/.cursor/skills-cursor"
        ln -sfn "$SOURCE_DIR" "$DEST_DIR"
        echo "✅ Installed '$SKILL_NAME' to Cursor (Global)"
        ;;
    "vscode")
        # VSCode Copilot Instructions standard (conceptual)
        DEST_FILE="$(pwd)/.github/copilot-instructions.md"
        mkdir -p "$(pwd)/.github"
        cat "$SOURCE_DIR/SKILL.md" >> "$DEST_FILE"
        echo "✅ Appended '$SKILL_NAME' to .github/copilot-instructions.md"
        ;;
    "print")
        echo "--- SKILL CONTENT FOR CLAUDE/OTHER AGENTS ---"
        cat "$SOURCE_DIR/SKILL.md"
        echo "--------------------------------------------"
        ;;
    *)
        echo "Unknown target: $TARGET"
        exit 1
        ;;
esac
