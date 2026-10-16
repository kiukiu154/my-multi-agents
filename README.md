# my-multi-agents

Multi-agent team (`coordinator` → `planner` → `cybersecurity` → `implementer` → `reviewer` → `start`) para **OpenCode, Claude Code, Cursor, VS Code (Copilot) y Codex**.

Reglas: [AGENTS.md](./AGENTS.md).

English version: [README.en.md](./README.en.md).

## Instalacion rapida (dentro del IDE, sin clonar)

En la terminal de tu proyecto pega una linea:

**Windows (PowerShell):**

```powershell
iex (irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.ps1)
```

**Linux/macOS:**

```sh
curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.sh | bash
```

> Canónico: `tools/install/` (6 instaladores). Compat: los 6 shims de la raíz (`install.*`, `quick-install.*`, `download.*`) delegan al canónico y siguen funcionando al clonar.

Solo una o varias plataformas:

```powershell
$env:AGENTS_PLATFORM="claude"; iex (irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.ps1)
```

```sh
curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.sh | AGENTS_PLATFORM="claude" bash
```

Valores: `opencode`, `claude`, `cursor`, `vscode`, `codex`, `all`.

## Descarga suelta (sin instalar en IDE)

Baja solo la carpeta que necesites a `downloads/<plataforma>/`:

**Windows:**

```powershell
irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/download.ps1 -OutFile download.ps1
.\download.ps1 -Platform claude
.\download.ps1 -Platform cursor,vscode -OutDir "$env:USERPROFILE\Downloads\agents"
```

**Linux/macOS:**

```sh
curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/download.sh -o download.sh
bash download.sh claude
bash download.sh cursor vscode --out ~/Downloads/agents
```

| Quiero | Contiene |
|---|---|
| `opencode` | `.opencode/agents/` + `AGENTS.md` |
| `claude` | `.claude/agents/` + `AGENTS.md` |
| `cursor` | `.cursor/agents/` + `.cursor/rules/` + `AGENTS.md` |
| `vscode` | `.github/agents/` + `AGENTS.md` |
| `codex` | `codex/prompts/` + `codex/workflow.md` + `AGENTS.md` |

Sin terminal: abre la carpeta en GitHub y usa `Code → Download ZIP`, o descarga una subcarpeta con [download-directory](https://download-directory.github.io/?url=https://github.com/kiukiu154/my-multi-agents/tree/main/.claude/agents) cambiando la ruta (`opencode`, `claude`, `cursor`, `vscode`, `codex`).

## Instalacion selectiva (clonando)

```sh
git clone https://github.com/kiukiu154/my-multi-agents.git
cd my-multi-agents
```

**Linux/macOS (canónico):**

```sh
./tools/install/install.sh --list
./tools/install/install.sh claude --dir ~/mi-proyecto
./tools/install/install.sh all --dir ~/mi-proyecto
```

Compat (shim raíz): `./install.sh` delega a `tools/install/install.sh`.

**Windows (canónico):**

```powershell
./tools/install/install.ps1 -List
./tools/install/install.ps1 -Platform claude -TargetDir C:\proj\miapp
./tools/install/install.ps1 -Platform all -TargetDir C:\proj\miapp
```

Compat (shim raíz): `.\install.ps1` delega a `tools/install/install.ps1`.

## Uso

- **OpenCode**: `Use coordinator to implement <tarea>.`
- **Claude Code**: `Use the coordinator agent for <tarea>.`
- **Cursor**: `@coordinator <tarea>`
- **VS Code**: selector de agente → `coordinator`
- **Codex**: pega `codex/prompts/coordinator.md` + tu tarea.

## Seguridad

Ver [SECURITY.md](./SECURITY.md). Licencia MIT — ver [LICENSE](./LICENSE).
