# my-multi-agents

Multi-agent team (`coordinator` → `planner` → `cybersecurity` → `implementer` → `reviewer` → `start`) for **OpenCode, Claude Code, Cursor, VS Code (Copilot) and Codex**.

Rules: [AGENTS.md](./AGENTS.md).

English version: this file is the English version. Volver al español: [README.md](./README.md).

## Quick install (inside the IDE, without cloning)

In your project terminal paste one line:

**Windows (PowerShell):**

```powershell
iex (irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.ps1)
```

**Linux / macOS:**

```sh
curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.sh | bash
```

> Canonical: `tools/install/` (6 installers). Compat: the 6 root shims (`install.*`, `quick-install.*`, `download.*`) delegate to the canonical path and keep working on clone.

Only one or several platforms:

```powershell
$env:AGENTS_PLATFORM="claude"; iex (irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.ps1)
```

```sh
curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.sh | AGENTS_PLATFORM="claude" bash
```

Values: `opencode`, `claude`, `cursor`, `vscode`, `codex`, `all`.

## Loose download (without installing in an IDE)

Download only the folder you need into `downloads/<platform>/`:

```powershell
irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/download.ps1 -OutFile download.ps1
.\download.ps1 -Platform claude
.\download.ps1 -Platform cursor,vscode -OutDir "$env:USERPROFILE\Downloads\agents"
```

```sh
curl -fsSL https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/download.sh -o download.sh
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
./tools/install/install.sh --list
./tools/install/install.sh claude --dir ~/mi-proyecto
./tools/install/install.sh all --dir ~/mi-proyecto
```

Compat (root shim): `./install.sh` delegates to `tools/install/install.sh`.

```powershell
./tools/install/install.ps1 -List
./tools/install/install.ps1 -Platform claude -TargetDir C:\proj\miapp
./tools/install/install.ps1 -Platform all -TargetDir C:\proj\miapp
```

Compat (root shim): `.\install.ps1` delegates to `tools/install/install.ps1`.

## Usage

- **OpenCode**: `Use coordinator to implement <task>.`
- **Claude Code**: `Use the coordinator agent for <task>.`
- **Cursor**: `@coordinator <task>`
- **VS Code**: agent picker → `coordinator`
- **Codex**: paste `codex/prompts/coordinator.md` + your task.

## Security

See [SECURITY.md](./SECURITY.md). MIT License — see [LICENSE](./LICENSE).
