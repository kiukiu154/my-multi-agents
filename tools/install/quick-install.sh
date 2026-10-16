#!/usr/bin/env bash
# Instalacion rapida: descarga el repo desde GitHub y delega en tools/install/install.sh.
# Uso normal (una linea en la terminal del IDE, situado en tu proyecto):
#   curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.sh | bash
# Solo unas plataformas (separadas por espacios):
#   curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.sh | AGENTS_PLATFORM="cursor vscode" bash
# Variables: AGENTS_PLATFORM (def: all), AGENTS_TARGET (def: .), AGENTS_REF (def: main)
set -euo pipefail
PLATFORM="${AGENTS_PLATFORM:-all}"
TARGET_DIR="${AGENTS_TARGET:-.}"
REF="${AGENTS_REF:-main}"
if ! [[ "$REF" =~ ^[A-Za-z0-9._-]+$ ]]; then echo "REF invalido: $REF" >&2; exit 1; fi
command -v unzip >/dev/null || { echo "falta 'unzip', instálalo y reintenta"; exit 1; }
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
curl -fsSL "https://github.com/kiukiu154/my-multi-agents/archive/refs/heads/$REF.zip" -o "$TMP/repo.zip"
unzip -q "$TMP/repo.zip" -d "$TMP/x"
bash "$TMP/x/my-multi-agents-$REF/tools/install/install.sh" $PLATFORM --dir "$TARGET_DIR"
echo "quick install done: $PLATFORM -> $TARGET_DIR"
