#!/usr/bin/env bash
# Instalacion rapida: descarga el repo desde GitHub y delega en install.sh.
# Uso normal (una linea en la terminal del IDE, situado en tu proyecto):
#   curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/quick-install.sh | bash
# Solo unas plataformas (separadas por espacios):
#   curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/quick-install.sh | AGENTS_PLATFORM="cursor vscode" bash
# Variables: AGENTS_PLATFORM (def: all), AGENTS_TARGET (def: .), AGENTS_REF (def: main)
set -euo pipefail
PLATFORM="${AGENTS_PLATFORM:-all}"
TARGET_DIR="${AGENTS_TARGET:-.}"
REF="${AGENTS_REF:-main}"
command -v unzip >/dev/null || { echo "falta 'unzip', instálalo y reintenta"; exit 1; }
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
curl -fsSL "https://github.com/kiukiu154/my-multi-agents/archive/refs/heads/$REF.zip" -o "$TMP/repo.zip"
unzip -q "$TMP/repo.zip" -d "$TMP/x"
# shellcheck disable=SC2086
bash "$TMP/x/my-multi-agents-$REF/install.sh" $PLATFORM --dir "$TARGET_DIR"
echo "quick install done: $PLATFORM -> $TARGET_DIR"
