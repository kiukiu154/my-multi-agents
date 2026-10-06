# Workflow manual en Codex (sin subagentes)

Codex es un unico agente que lee `AGENTS.md` automaticamente. Emula al equipo multi-agente por fases, pegando cada prompt en orden:

1. Pega `codex/prompts/coordinator.md` + tu tarea. Codex organiza el trabajo por fases.
2. O ejecuta fase por fase:
   - `codex/prompts/planner.md` + tarea → guarda el contexto.
   - `codex/prompts/cybersecurity.md` + contexto (solo si toca backend, auth, datos, dependencias o APIs).
   - `codex/prompts/implementer.md` + contexto + requisitos.
   - `codex/prompts/reviewer.md` + diff → exige VEREDICTO: APROBADO / CAMBIOS NECESARIOS.
   - Si CAMBIOS NECESARIOS → vuelve a implementer, repite reviewer.
   - `codex/prompts/start.md` solo tras APROBADO.

Instalacion: copia `AGENTS.md` a la raiz de tu proyecto. Codex lo carga solo. Los prompts de `codex/prompts/` no se instalan: se pegan a mano cuando los necesites.
