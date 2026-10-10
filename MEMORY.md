# MEMORY.md - Registro de cambios grandes

## 2026-10-10 - Ampliación preguntas + README inglés
- Fecha: 2026-10-10
- Agente que lo detectó: planner (a petición de implementer vía coordinator, OPCIÓN A)
- Motivo: mezcla baseline previo APROBADO (endurecimiento sin bilingüe, auditoría frontmatter, verificación sin arranque) + incremental vigente (planner+coordinator preguntan siempre ante cualquier duda menor máx 5/turno con excepción bilingüe solo preguntas, README.en.md separado, sync+verify). Ampliar contexto de 3 a 8 ficheros cambia arquitectura/contratos/criterios. Aprobado por orquestador como "Aprobar alcance ampliado".
- Archivos:
  - Baseline previo: .opencode/agents/cybersecurity.md, .opencode/agents/implementer.md, .opencode/agents/reviewer.md, .opencode/agents/start.md
  - Incremental: .opencode/agents/planner.md, .opencode/agents/coordinator.md, README.md, README.en.md (nuevo)
  - Propagados vía tools/sync-agents.ps1: .claude/agents/planner.md, .claude/agents/coordinator.md, .cursor/agents/planner.md, .cursor/agents/coordinator.md, .github/agents/planner.agent.md, .github/agents/coordinator.agent.md, codex/prompts/planner.md, codex/prompts/coordinator.md (+ resto reescritos por sync)
  - Verificación: verify OK 6 agentes x 5 plataformas exit 0, git diff AGENTS.md vacío

## 2026-10-10 - Añadir MCP filesystem local + rotar secreto context7
- Fecha: 2026-10-10
- Agente que lo detectó: planner (contexto corregido vía coordinator, con requisitos cybersecurity SIN HALLAZGOS)
- Motivo: petición original "revisa los MCP y mira cual puedes anadir"; decisiones orquestador (Filesystem, Solo locales gratis, Mantener ambos con excepción context7, raíz única C:\Users\abalp\Downloads\my-multi-agents, npx oficial @modelcontextprotocol/server-filesystem@2026.8.31, rotar secreto a env, docs con placeholders). Cambio GRANDE (nuevo servidor MCP + nueva estructura docs/examples). Aprobado por reviewer VEREDICTO: APROBADO, start OK.
- Archivos:
  - Modificado: C:\Users\abalp\.config\opencode\opencode.json (filesystem local pineado @2026.8.31 raíz única + Authorization a Bearer {env:CONTEXT7_API_KEY}, cero ctx7sk)
  - Creado: docs/mcp-filesystem.md
  - Creado: examples/mcp/opencode-filesystem.fragment.json
  - Verificación: Get-Content OK ambos, Select-String ctx7sk SIN HALLAZGOS, Select-String latest SIN HALLAZGOS, npm view 2026.8.31 + shasum 7f88dfab06d4521a4bf937dccbaeb79d46a3e717 idénticos, Test-Path True x2, opencode mcp list ambos connected, read fuera DENEGADO, verify-agents verify OK exit 0

## 2026-10-10 - Publicar blindaje + sync agentes + README bilingüe
- Fecha: 2026-10-10
- Agente que lo ejecutó: implementer (vía coordinator, con autorización explícita del orquestador)
- Motivo: petición "no me aparece que se actualizo"; causa commit/push pendiente (HEAD 1a9d40c == origin/main). Alcance Completo 33M+5U.
- Archivos: 33 modificados + 5 creados (.env.example, MEMORY.md, README.en.md, docs/mcp-filesystem.md, examples/mcp/opencode-filesystem.fragment.json); 38 files, +819/-167.
- Commit: 8ad45245642b1833ac58d502ba5d60e59735ec8d "chore(security): blindaje + sync agentes + README bilingüe"; push origin main 1a9d40c..8ad4524 OK, ls-remote HEAD == 8ad4524, status limpio, verify OK exit 0, sin force, sin secretos.
