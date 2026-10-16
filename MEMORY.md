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

## 2026-10-16 - Flujo continuo router + ID corrida
- Fecha: 2026-10-16
- Agente que lo detectó: planner (vía coordinator RUN-20261016-001, con requisitos cybersecurity SIN HALLAZGOS)
- Motivo: petición literal "todos los agentes (coordinator.md, planner.md y demas)deneran estar interconectados, ya no solo como llamamiento si no como un flujo continuo"; decisiones Q1 router+ID único enrutador, Q2 alcance ampliado, Q3 payload+bus ligero, Q4 mantener guardián 3 ciclos y validador, Q5 verify verde+cadena+diff. Cambio GRANDE (payload encadenado + ID RUN-YYYYMMDD-NNN + fase + historial, bus ligero MEMORY/TASK, verificación cadena). Aprobado por reviewer VEREDICTO: APROBADO, start OK exit 0.
- Archivos:
  - Modificados directos (10): .opencode/agents/coordinator.md, .opencode/agents/planner.md, .opencode/agents/cybersecurity.md, .opencode/agents/implementer.md, .opencode/agents/reviewer.md, .opencode/agents/start.md, AGENTS.md (línea 8 flujo continuo), codex/workflow.md, .cursor/rules/multi-agent-workflow.mdc, tools/verify-agents.ps1 (Assert-FlujoContinuo solo lectura)
  - Propagados vía tools/sync-agents.ps1 (24, SIN CAMBIOS en sync): .claude/agents/*.md (6), .cursor/agents/*.md (6), .github/agents/*.agent.md (6), codex/prompts/*.md (6)
  - Verificación: sync 24 + done, verify OK 6x5 exit 0 sin DIVERGE, diff 34 files +159/-0, grep Flujo continuo 12 / ID de corrida 7 / RUN 6 canónicos
  - Corrida: RUN-20261016-001|plan+security+build+review+operate+cierre

## 2026-10-16 - Añadir MCP memory + sequential-thinking locales
- Fecha: 2026-10-16
- Agente que lo detectó: planner (vía coordinator RUN-20261016-002, con requisitos cybersecurity SIN HALLAZGOS)
- Motivo: petición literal "busca mcp de terceros para funcionamiento de sub agentes con mejor rendimiento e instalalos"; decisiones (tokens, Solo locales gratis, Permitir con env, añadir al sistema manteniendo filesystem+context7, Multiplataforma). Cambio GRANDE (2 nuevos MCP + docs/examples, ante duda se trata como grande). Aprobado por reviewer VEREDICTO: APROBADO, start OK.
- Archivos:
  - Modificado: C:\Users\abalp\.config\opencode\opencode.json (añadidos memory@1.0.0 + sequential-thinking@1.0.0 locales, mantenidos context7+filesystem)
  - Creado: docs/mcp-performance.md
  - Creado: examples/mcp/opencode-performance.fragment.json
  - Verificación: npm view versiones+shasum OK, Test-Path True x2, Select-String ctx7sk/latest SIN HALLAZGOS, opencode mcp list 4 connected, verify-agents OK 6x5 exit 0
  - Corrida: RUN-20261016-002|plan+security+build+review+operate+cierre

## 2026-10-16 - Añadir 1 skill por agente (sección en cuerpo)
- Fecha: 2026-10-16
- Agente que lo detectó: planner (vía coordinator RUN-20261016-003, con requisitos cybersecurity SIN HALLAZGOS)
- Motivo: petición literal "para cada agente anadele una skill que mejore su funcion, para que mejore contexto y sea mas eficiente"; decisiones Q1 sección markdown en cuerpo, Q2 5 plataformas vía sync, Q3 frontmatter intacto/BLOQUEANTE si se amplía, Q4 1 skill por agente propuesta por planner, Q5 verify verde+cadena+diff acotado+registro. Cambio GRANDE (6 contratos + propagación). Aprobado por reviewer VEREDICTO: APROBADO, start OK exit 0.
- Archivos:
  - Modificados directos (6): .opencode/agents/coordinator.md, .opencode/agents/planner.md, .opencode/agents/cybersecurity.md, .opencode/agents/implementer.md, .opencode/agents/reviewer.md, .opencode/agents/start.md (solo sección ## Habilidad aditiva +9 líneas antes de ## Flujo continuo, sin frontmatter/permissions)
  - Propagados vía tools/sync-agents.ps1 (24): .claude/agents/*.md (6), .cursor/agents/*.md (6), .github/agents/*.agent.md (6), codex/prompts/*.md (6)
  - Verificación: tools/verify-agents.ps1 exit 0 verify OK 6x5 sin DIVERGE, Select-String ## Habilidad 6/6 + Flujo continuo 6/6 + ID de corrida 6/6, diff 30 agentes +9 c/u frontmatter cero
  - Corrida: RUN-20261016-003|plan+security+build+review+operate+cierre

