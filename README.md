# my-multi-agents

Multi-agent team (`coordinator` → `planner` → `cybersecurity` → `implementer` → `reviewer` → `start`) para **OpenCode, Claude Code, Cursor, VS Code (Copilot) y Codex**.

Reglas: [AGENTS.md](./AGENTS.md).

## Instalacion rapida (dentro del IDE, sin clonar)

En la terminal de tu proyecto pega una linea:

**Windows (PowerShell):**

```powershell
iex (irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/quick-install.ps1)
```

**Linux / macOS:**

```sh
curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/quick-install.sh | bash
```

Solo una o varias plataformas:

```powershell
$env:AGENTS_PLATFORM="claude"; iex (irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/quick-install.ps1)
```

```sh
curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/quick-install.sh | AGENTS_PLATFORM="claude" bash
```

Valores: `opencode`, `claude`, `cursor`, `vscode`, `codex`, `all`.

## Descarga suelta (sin instalar en IDE)

Baja solo la carpeta que necesites a `downloads/<plataforma>/`:

```powershell
irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/download.ps1 -OutFile download.ps1
.\download.ps1 -Platform claude
.\download.ps1 -Platform cursor,vscode -OutDir "$env:USERPROFILE\Downloads\agents"
```

```sh
curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/download.sh -o download.sh
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

```sh
./install.sh --list
./install.sh claude --dir ~/mi-proyecto
./install.sh all --dir ~/mi-proyecto
```

```powershell
.\install.ps1 -List
.\install.ps1 -Platform claude -TargetDir C:\proj\miapp
.\install.ps1 -Platform all -TargetDir C:\proj\miapp
```

## Uso

- **OpenCode**: `Use coordinator to implement <tarea>.`
- **Claude Code**: `Use the coordinator agent for <tarea>.`
- **Cursor**: `@coordinator <tarea>`
- **VS Code**: selector de agente → `coordinator`
- **Codex**: pega `codex/prompts/coordinator.md` + tu tarea.

## Seguridad

Ver [SECURITY.md](./SECURITY.md). Licencia MIT — ver [LICENSE](./LICENSE).
