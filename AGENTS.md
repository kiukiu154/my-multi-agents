# AGENTS.md - Limitaciones y reglas para agentes en .opencode/agents/

## Ambito
Aplica a coordinator, planner, cybersecurity, implementer, reviewer y start.

## Cadena de mando
1. El orquestador (usuario / agente principal) solo habla con @coordinator.
2. @coordinator reparte a @planner -> @cybersecurity -> @implementer -> @reviewer -> @start.
3. @planner llama a @cybersecurity (via @coordinator) cuando el cambio toca backend, auth, datos, dependencias o APIs.
4. @cybersecurity trabaja junto a @implementer (via @coordinator) y le pasa su informe a @reviewer (via @coordinator).
5. @reviewer llama a @start (via @coordinator) cuando su veredicto es APROBADO.
6. Ningun subagente llama a otro directamente fuera de lo anterior. Toda duda o peticion va a @coordinator y el la eleva al orquestador.
7. Flujo de correccion: reviewer -> coordinator -> implementer -> coordinator -> reviewer.

## Limitaciones (prohibido)
- Prohibido salirse del contexto: cada agente solo hace lo que le pide @coordinator en esa llamada. No anades extras, refactors ni mejoras no pedidas.
- Prohibido hacer lo no mandado: si el plan no lo cubre, PARAS y lo escalas en lugar de improvisar.
- Prohibido saltarse aprobaciones: cambio grande de arquitectura sin aprobacion del orquestador.
- Prohibido redisenar por tu cuenta (implementer) o editar codigo (planner, reviewer, cybersecurity, start, coordinator por convenio).
- Prohibido dar por hecha una tarea con tests en rojo.
- Prohibido iniciar el servidor sin veredicto APROBADO de reviewer (solo @start, via @coordinator).
- Prohibido modificar archivos fuera de tu rol:
  - coordinator: por convenio no edita codigo, solo coordina.
  - planner: no edita codigo, solo lee y devuelve contexto.
  - cybersecurity: no edita codigo, solo audita y devuelve informe con requisitos.
  - implementer: solo edita lo indicado en el contexto (+ requisitos de cybersecurity).
  - reviewer: no edita nada, solo reporta.
  - start: no edita nada, solo arranca el servidor tras APROBADO.

## Cambio grande vs menor
- Grande: cambia arquitectura, contratos/interfaces, stack, estructura de carpetas, modelo de datos o criterios de aceptacion. Requiere aprobacion del orquestador via @coordinator y registro en MEMORY.md.
- Menor: renombrado interno, ajuste de implementacion sin cambiar contratos. Lo aprueba @planner sin molestar al orquestador, pero igual se anota en el resumen de la respuesta.

## Registro obligatorio
Todo cambio grande se registra en MEMORY.md con fecha, agente, motivo y archivos. Si el agente no tiene permiso de edicion, devuelve el registro a @coordinator para que lo escriba.

## TASK.md - Ideas
Cualquier agente puede proponer en TASK.md tareas necesarias: optimizacion del proyecto, ideas de implementacion o mejoras en la arquitectura base.
- Formato: `- [nombre-agente] idea en menos de una linea`.
- Si una idea es ejecutada o se ejecuta una parecida, se borra del archivo.
- Proponer ideas no es salirse del contexto: es el canal oficial para mejoras no pedidas. Ejecutarlas sin aprobacion si lo es.
