# my-multi-agents

Multi-agent team (`coordinator` → `planner` → `cybersecurity` → `implementer` → `reviewer` → `start`) for **OpenCode, Claude Code, Cursor, VS Code (Copilot) and Codex**.

Rules: [AGENTS.md](./AGENTS.md).

English version: this file is the English version. Volver al español: [README.md](./README.md).

## Quick install (inside the IDE, without cloning)

In your project terminal paste one line:

**Windows (PowerShell):**

```powershell
iex (irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/quick-install.ps1)
```

**Linux / macOS:**

```sh
curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/quick-install.sh | bash
```

Only one or several platforms:

```powershell
$env:AGENTS_PLATFORM="claude"; iex (irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/quick-install.ps1)
```

```sh
curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/quick-install.sh | AGENTS_PLATFORM="claude" bash
```

Values: `opencode`, `claude`, `cursor`, `vscode`, `codex`, `all`.

## Loose download (without installing in an IDE)

Download only the folder you need into `downloads/<platform>/`:

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

| I want | It contains |
|---|---|
| `opencode` | `.opencode/agents/` + `AGENTS.md` |
| `claude` | `.claude/agents/` + `AGENTS.md` |
| `cursor` | `.cursor/agents/` + `.cursor/rules/` + `AGENTS.md` |
| `vscode` | `.github/agents/` + `AGENTS.md` |
| `codex` | `codex/prompts/` + `codex/workflow.md` + `AGENTS.md` |

Without a terminal: open the folder on GitHub and use `Code → Download ZIP`, or download a subfolder with [download-directory](https://download-directory.github.io/?url=https://github.com/kiukiu154/my-multi-agents/tree/main/.claude/agents) changing the path (`opencode`, `claude`, `cursor`, `vscode`, `codex`).

## Selective install (by cloning)

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

## Usage

- **OpenCode**: `Use coordinator to implement <task>.`
- **Claude Code**: `Use the coordinator agent for <task>.`
- **Cursor**: `@coordinator <task>`
- **VS Code**: agent picker → `coordinator`
- **Codex**: paste `codex/prompts/coordinator.md` + your task.

## Security

See [SECURITY.md](./SECURITY.md). MIT License — see [LICENSE](./LICENSE).
