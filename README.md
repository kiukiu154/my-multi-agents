# my-multi-agents

Multi-agent team (`coordinator` → `planner` → `cybersecurity` → `implementer` → `reviewer` → `start`) packaged for **OpenCode, Claude Code, Cursor, VS Code (Copilot) y Codex**.

Instala solo lo que necesites: una plataforma o todas.

## Contenido por plataforma

| Plataforma | Carpeta en este repo | Destino en tu proyecto | Global (usuario) |
|---|---|---|---|
| OpenCode | `.opencode/agents/*.md` | `<proj>/.opencode/agents/` + `AGENTS.md` | `~/.config/opencode/agents/` (Win: `%USERPROFILE%\.config\opencode\agents\`) |
| Claude Code | `.claude/agents/*.md` | `<proj>/.claude/agents/` + `AGENTS.md` | `~/.claude/agents/` |
| Cursor | `.cursor/agents/*.md` + `.cursor/rules/*.mdc` | `<proj>/.cursor/agents/` + `<proj>/.cursor/rules/` + `AGENTS.md` | `~/.cursor/agents/` (las rules van por proyecto) |
| VS Code / Copilot | `.github/agents/*.agent.md` | `<proj>/.github/agents/` + `AGENTS.md` | `~/.copilot/agents/` |
| Codex (OpenAI) | `codex/prompts/*.md` + `codex/workflow.md` | `<proj>/AGENTS.md` (+ `codex/` opcional) | `~/.codex/AGENTS.md` |

Notas:
- Cursor, Copilot y Codex leen `AGENTS.md` de la raiz automaticamente: copialo siempre al proyecto.
- Codex no tiene subagentes nativos: se emula por fases pegando los prompts de `codex/prompts/` en orden (ver `codex/workflow.md`).
- VS Code tambien detecta `.claude/agents/*.md`, asi que con instalar `claude` ya tienes cobertura parcial en VS Code.

## Agentes (6, mismos en todas las plataformas)

- **coordinator** — reparte trabajo, unico contacto del orquestador.
- **planner** — planifica arquitectura, produce contexto (no edita).
- **cybersecurity** — audita seguridad, devuelve informe + requisitos (no edita).
- **implementer** — edita codigo segun contexto + requisitos.
- **reviewer** — revisa sin editar. Veredicto `APROBADO` / `CAMBIOS NECESARIOS`.
- **start** — arranca servidor (`npm start`) solo tras APROBADO, chequea `GET /api/health`.

Reglas: [AGENTS.md](./AGENTS.md). Flujo: `orchestrator → coordinator → planner → cybersecurity → implementer → reviewer → start` (correccion: reviewer → coordinator → implementer).

## Instalacion selectiva

Clona una vez:

```sh
git clone https://github.com/kiukiu154/my-multi-agents.git
cd my-multi-agents
```

### Linux / macOS (`install.sh`)

```sh
./install.sh --list                          # ver que instala cada plataforma
./install.sh claude --dir ~/mi-proyecto      # solo Claude, a un proyecto
./install.sh cursor vscode --dir ~/mi-proyecto
./install.sh codex --dir ~/mi-proyecto        # AGENTS.md + prompts manuales
./install.sh all --dir ~/mi-proyecto          # todo
./install.sh --global opencode claude         # nivel usuario (todas tus repos)
./install.sh --global all
```

### Windows (`install.ps1`)

```powershell
.\install.ps1 -List
.\install.ps1 -Platform claude -TargetDir C:\proj\miapp
.\install.ps1 -Platform cursor,vscode -TargetDir C:\proj\miapp
.\install.ps1 -Platform codex -TargetDir C:\proj\miapp
.\install.ps1 -Platform all -TargetDir C:\proj\miapp
.\install.ps1 -Platform opencode,claude -Global
.\install.ps1 -Platform all -Global
```

### Sin git

GitHub → `Code → Download ZIP` → extrae → copia a mano la carpeta de la plataforma que quieras segun la tabla de arriba.

## Uso por plataforma

- **OpenCode**: `opencode` → `Use coordinator to implement <tarea>.`
- **Claude Code**: `/agents` verifica los 6 → `Use the coordinator agent for <tarea>.`
- **Cursor**: `@coordinator <tarea>` (las rules de `.cursor/rules/` aplican el flujo solas).
- **VS Code**: selector de agente → `coordinator` → pide la tarea; usa los botones de `handoffs` para pasar de fase.
- **Codex**: pega `codex/prompts/coordinator.md` + tu tarea, o sigue `codex/workflow.md` fase por fase.

## Verificar

```sh
ls .opencode/agents/  # opencode
ls .claude/agents/    # claude
ls .cursor/agents/ .cursor/rules/  # cursor
ls .github/agents/    # vscode
ls codex/prompts/     # codex
```

## Subir a GitHub

```sh
cd my-multi-agents
git add .
git commit -m "feat: multi-platform agents (opencode, claude, cursor, vscode, codex) with selective install"
git branch -M main
git remote add origin https://github.com/kiukiu154/my-multi-agents.git
git push -u origin main
```

## License

MIT — ver [LICENSE](./LICENSE).

## Seguridad

Ver [SECURITY.md](./SECURITY.md) para reportar vulnerabilidades y el baseline que los agentes exigen.
