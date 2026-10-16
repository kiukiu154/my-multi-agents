#!/usr/bin/env bash
# Descarga suelta: baja solo la carpeta que necesites, sin instalar en ningun IDE.
# Ejemplos:
#   ./tools/install/download.sh claude
#   ./tools/install/download.sh cursor vscode --out ~/Downloads/agents
#   ./tools/install/download.sh all
# Compat: ./download.sh delega aqui (shim fino).
set -euo pipefail
REF="${AGENTS_REF:-main}"
if ! [[ "$REF" =~ ^[A-Za-z0-9._-]+$ ]]; then echo "REF invalido: $REF" >&2; exit 1; fi
OUT_BASE="./downloads"
PLATFORMS=()

while [ $# -gt 0 ]; do
  case "$1" in
    --out) OUT_BASE="${2:?falta valor para --out}"; shift 2 ;;
    --ref) REF="${2:?falta valor para --ref}"; if ! [[ "$REF" =~ ^[A-Za-z0-9._-]+$ ]]; then echo "REF invalido: $REF" >&2; exit 1; fi; shift 2 ;;
    opencode|claude|cursor|vscode|codex|all) PLATFORMS+=("$1"); shift ;;
    *) echo "arg desconocido: $1 (usa: opencode claude cursor vscode codex all [--out DIR])"; exit 1 ;;
  esac
done
[ ${#PLATFORMS[@]} -eq 0 ] && PLATFORMS=(claude)

EXPANDED=()
for p in "${PLATFORMS[@]}"; do
  if [ "$p" = "all" ]; then EXPANDED+=(opencode claude cursor vscode codex); else EXPANDED+=("$p"); fi
done

command -v unzip >/dev/null || { echo "falta 'unzip', instálalo y reintenta"; exit 1; }
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
curl -fsSL "https://github.com/kiukiu154/my-multi-agents/archive/refs/heads/$REF.zip" -o "$TMP/repo.zip"
unzip -q "$TMP/repo.zip" -d "$TMP/x"
SRC="$TMP/x/my-multi-agents-$REF"

copy_rel() { # $1=src_base $2=rel $3=dest_base
  local from="$1/$2" dest="$3/$2"
  if [ -d "$from" ]; then
    mkdir -p "$dest"
    cp -f "$from/"* "$dest/"
  elif [ -f "$from" ]; then
    mkdir -p "$(dirname "$dest")"
    cp -f "$from" "$dest"
  fi
}

needed() { # $1=platform -> lista en stdout
  case "$1" in
    opencode) printf '%s\n' ".opencode/agents" "AGENTS.md" ;;
    claude)   printf '%s\n' ".claude/agents" "AGENTS.md" ;;
    cursor)   printf '%s\n' ".cursor/agents" ".cursor/rules" "AGENTS.md" ;;
    vscode)   printf '%s\n' ".github/agents" "AGENTS.md" ;;
    codex)    printf '%s\n' "codex/prompts" "codex/workflow.md" "AGENTS.md" ;;
    *) echo "plataforma desconocida: $1" >&2; exit 1 ;;
  esac
}

for p in "${EXPANDED[@]}"; do
  dest="$OUT_BASE/$p"
  mkdir -p "$dest"
  while IFS= read -r rel; do
    copy_rel "$SRC" "$rel" "$dest"
  done < <(needed "$p")
  echo "descargado [$p] -> $dest"
done
echo "done."
