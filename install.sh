#!/usr/bin/env bash
set -euo pipefail
# Selective installer: ./install.sh [opencode|claude|cursor|vscode|codex|all] [--global] [--dir PATH]
# Examples:
#   ./install.sh --list
#   ./install.sh claude --dir ~/myproj        # project install (default)
#   ./install.sh cursor vscode --dir ~/myproj
#   ./install.sh --global opencode claude     # user-level install
#   ./install.sh all --dir ~/myproj

SRC_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="."
GLOBAL=0
PLATFORMS=()

usage() {
  echo "Usage: ./install.sh [platforms...] [--global] [--dir PATH]"
  echo "Platforms: opencode claude cursor vscode codex all (default: all)"
  echo "  --global   install to user-level dirs instead of a project dir"
  echo "  --dir PATH project target dir (default: .)"
  echo "  --list     show source files per platform"
  echo "  --help     this help"
}

list_sources() {
  echo "opencode: .opencode/agents/*.md + AGENTS.md"
  ls "$SRC_DIR/.opencode/agents/"
  echo "--- claude: .claude/agents/*.md"
  ls "$SRC_DIR/.claude/agents/"
  echo "--- cursor: .cursor/agents/*.md + .cursor/rules/*.mdc + AGENTS.md"
  ls "$SRC_DIR/.cursor/agents/" "$SRC_DIR/.cursor/rules/"
  echo "--- vscode: .github/agents/*.agent.md"
  ls "$SRC_DIR/.github/agents/"
  echo "--- codex: AGENTS.md + codex/prompts/*.md + codex/workflow.md"
  ls "$SRC_DIR/codex/prompts/" "$SRC_DIR/codex/workflow.md"
}

install_project() {
  local p="$1" dest="$2"
  case "$p" in
    opencode)
      mkdir -p "$dest/.opencode/agents"
      cp -f "$SRC_DIR/.opencode/agents/"*.md "$dest/.opencode/agents/"
      [ -f "$dest/AGENTS.md" ] || cp -f "$SRC_DIR/AGENTS.md" "$dest/AGENTS.md"
      ;;
    claude)
      mkdir -p "$dest/.claude/agents"
      cp -f "$SRC_DIR/.claude/agents/"*.md "$dest/.claude/agents/"
      [ -f "$dest/AGENTS.md" ] || cp -f "$SRC_DIR/AGENTS.md" "$dest/AGENTS.md"
      ;;
    cursor)
      mkdir -p "$dest/.cursor/agents" "$dest/.cursor/rules"
      cp -f "$SRC_DIR/.cursor/agents/"*.md "$dest/.cursor/agents/"
      cp -f "$SRC_DIR/.cursor/rules/"*.mdc "$dest/.cursor/rules/"
      [ -f "$dest/AGENTS.md" ] || cp -f "$SRC_DIR/AGENTS.md" "$dest/AGENTS.md"
      ;;
    vscode)
      mkdir -p "$dest/.github/agents"
      cp -f "$SRC_DIR/.github/agents/"*.agent.md "$dest/.github/agents/"
      [ -f "$dest/AGENTS.md" ] || cp -f "$SRC_DIR/AGENTS.md" "$dest/AGENTS.md"
      ;;
    codex)
      [ -f "$dest/AGENTS.md" ] || cp -f "$SRC_DIR/AGENTS.md" "$dest/AGENTS.md"
      mkdir -p "$dest/codex/prompts"
      cp -f "$SRC_DIR/codex/prompts/"*.md "$dest/codex/prompts/"
      cp -f "$SRC_DIR/codex/workflow.md" "$dest/codex/workflow.md"
      ;;
  esac
  echo "installed [$p] -> $dest"
}

install_global() {
  local p="$1"
  local base="${XDG_CONFIG_HOME:-$HOME/.config}"
  case "$p" in
    opencode)
      mkdir -p "$base/opencode/agents"
      cp -f "$SRC_DIR/.opencode/agents/"*.md "$base/opencode/agents/"
      echo "installed [$p] -> $base/opencode/agents/"
      ;;
    claude)
      mkdir -p "$HOME/.claude/agents"
      cp -f "$SRC_DIR/.claude/agents/"*.md "$HOME/.claude/agents/"
      echo "installed [$p] -> $HOME/.claude/agents/"
      ;;
    cursor)
      mkdir -p "$HOME/.cursor/agents"
      cp -f "$SRC_DIR/.cursor/agents/"*.md "$HOME/.cursor/agents/"
      echo "installed [$p] -> $HOME/.cursor/agents/"
      echo "note: copy .cursor/rules/*.mdc + AGENTS.md per project for full workflow"
      ;;
    vscode)
      mkdir -p "$HOME/.copilot/agents"
      cp -f "$SRC_DIR/.github/agents/"*.agent.md "$HOME/.copilot/agents/"
      echo "installed [$p] -> $HOME/.copilot/agents/"
      ;;
    codex)
      mkdir -p "$HOME/.codex"
      cp -f "$SRC_DIR/AGENTS.md" "$HOME/.codex/AGENTS.md"
      echo "installed [$p] -> $HOME/.codex/AGENTS.md"
      echo "note: codex prompts are manual, see codex/workflow.md"
      ;;
  esac
}

while [ $# -gt 0 ]; do
  case "$1" in
    --help|-h) usage; exit 0 ;;
    --list) list_sources; exit 0 ;;
    --global) GLOBAL=1; shift ;;
    --dir) TARGET_DIR="$2"; shift 2 ;;
    opencode|claude|cursor|vscode|codex|all) PLATFORMS+=("$1"); shift ;;
    *) echo "unknown arg: $1"; usage; exit 1 ;;
  esac
done

if [ ${#PLATFORMS[@]} -eq 0 ]; then PLATFORMS=(all); fi
EXPANDED=()
for p in "${PLATFORMS[@]}"; do
  if [ "$p" = "all" ]; then EXPANDED+=(opencode claude cursor vscode codex); else EXPANDED+=("$p"); fi
done

for p in "${EXPANDED[@]}"; do
  if [ "$GLOBAL" -eq 1 ]; then install_global "$p"; else install_project "$p" "$TARGET_DIR"; fi
done
echo "done."
