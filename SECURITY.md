# Politica de seguridad

## Alcance

Este repositorio contiene **definiciones de agentes** (prompts + permisos) y scripts de instalacion, no software en ejecucion. Aun asi, una instruccion o un permiso mal disenado puede debilitar la seguridad de los proyectos donde se usen. Esta politica cubre:

- Los 6 agentes en sus 5 plataformas (`.opencode`, `.claude`, `.cursor`, `.github`, `codex`).
- `AGENTS.md` (cadena de mando y limitaciones).
- Scripts `install.sh` / `install.ps1` y herramientas en `tools/`.

## Como reportar una vulnerabilidad

No abras un issue publico con los detalles. Usa uno de estos canales:

1. GitHub: pestaña **Security → Report a vulnerability** (aviso privado).
2. Email: **abalpintohugo@gmail.com** con asunto `[SECURITY] my-multi-agents`.

Incluye: descripcion, archivos afectados, impacto y, si puedes, prueba de concepto y remedio sugerido. Respuesta prevista en 7 dias.

## Que se considera vulnerabilidad aqui

- Un agente que pida desactivar verificaciones (tests, revision de seguridad, aprobaciones) o saltarse la cadena de mando.
- Permisos excesivos en frontmatter (p. ej. un `reviewer`/`planner` con edicion, o un `coordinator` que edite codigo).
- Contenido que facilite exfiltracion, ejecucion remota o persistencia fuera del proyecto.
- Scripts de instalacion que escriban fuera de sus destinos documentados o descarguen codigo externo.
- Instrucciones que normalicen secretos en el repo, auth debil o validacion ausente.

## Baseline que los agentes exigen a tus proyectos

El agente `cybersecurity` audita (solo lectura) estos controles y `reviewer` los verifica punto por punto antes de cualquier `APROBADO`:

- Sin secretos en el repo (`.env`, `JWT_SECRET`); passwords con bcrypt.
- JWT con expiracion corta y cookies `HttpOnly` + `SameSite`.
- Helmet + CSP, CORS con origenes explicitos, rate limiting global y en auth.
- Validacion con zod en frontera, `sanitize-html` en RSS/HTML, prepared statements en SQLite.
- Errores genericos al cliente, detalle solo en logs; `.db` y sensibles con permisos restrictivos.

Detalle completo en el agente `cybersecurity` de cada plataforma.

## Reglas para contribuir

- No propongas instrucciones que relajen verificaciones ni que otorguen edicion a `planner`, `reviewer`, `cybersecurity`, `start` o `coordinator`.
- Todo cambio en agentes debe propagarse a las 5 plataformas con `tools/sync-agents.ps1` y pasar `tools/verify-agents.ps1`.
- Los cambios grandes de arquitectura de los agentes requieren discussion previa en un issue.
