# MCP filesystem local (opencode)

## Objetivo

Anadir servidor MCP `filesystem` local con raiz unica y mantener `context7`
remoto como excepcion documentada. Sin secretos en ficheros.

## Configuracion canonica (`opencode.json`)

Ubicacion: `C:\Users\abalp\.config\opencode\opencode.json`.

```json
{
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com/mcp",
      "enabled": true,
      "headers": {
        "Authorization": "Bearer {env:CONTEXT7_API_KEY}"
      }
    },
    "filesystem": {
      "type": "local",
      "command": [
        "npx",
        "-y",
        "@modelcontextprotocol/server-filesystem@<VERSION-FIJADA>",
        "<RAIZ-UNICA>"
      ],
      "enabled": true
    }
  }
}
```

Valores verificados (ejemplo, no copiar sin verificar):

- Paquete: `@modelcontextprotocol/server-filesystem`
- `<VERSION-FIJADA>` verificada via `npm view`: `2026.8.31`
- `shasum` verificado via `npm view`: `7f88dfab06d4521a4bf937dccbaeb79d46a3e717`
- `<RAIZ-UNICA>`: `C:\Users\abalp\Downloads\my-multi-agents`

Prohibido `latest`, `^` o `~`. Solo una ruta. Sin `url`, sin `headers`,
sin secretos en `filesystem`.

## Excepcion ambos (`context7` + `filesystem`)

- `context7`: remoto, `url` intacta, `enabled: true`, cero secretos en fichero.
- `filesystem`: local, `enabled: true`, sin red.
- Se mantienen ambos por decision de orquestador. No anadir mas servidores
  sin aprobacion.

## Rotacion del secreto `context7`

El fichero no contiene `ctx7sk-*`. Usa sustitucion oficial
`{env:CONTEXT7_API_KEY}` (en JSON no se expande `$env:` ni `$NAME`).

Pasos en Windows (PowerShell):

```powershell
$env:CONTEXT7_API_KEY = '<PEGAR-AQUI-SU-CLAVE>'
# Verificar que no hay secreto en claro:
Select-String -Path $env:USERPROFILE\.config\opencode\opencode.json -Pattern 'ctx7sk' -SimpleMatch
# Sin hallazgos = OK. Revocar la clave anterior en el dashboard de Context7.
```

Fallo cerrado: si `CONTEXT7_API_KEY` no esta definida, se envia cadena
vacia y el remoto falla sin exponer nada. No escribir la clave en
`docs/` ni en `examples/`.

## ACL por defecto y matriz de denegacion

ACL por defecto: DENEGAR. Solo se permite leer/escribir bajo `<RAIZ-UNICA>`.

| Caso | Resultado esperado |
| --- | --- |
| Lectura dentro de `<RAIZ-UNICA>` | PERMITIDO |
| Lectura fuera de `<RAIZ-UNICA>` (p. ej. `C:\Windows`, `C:\Users\abalp\.config`) | DENEGADO |
| Segunda ruta en `command` | DENEGADO (configuracion invalida, solo una ruta) |
| `url` o `headers` en `filesystem` | DENEGADO (no incluir) |
| Secreto `ctx7sk-*` en cualquier fichero del repo o en `opencode.json` | DENEGADO (usar `{env:CONTEXT7_API_KEY}`) |
| Version `latest`, `^` o `~` | DENEGADO (usar `<VERSION-FIJADA>` pineada y verificada) |

Ver plantilla: `examples/mcp/opencode-filesystem.fragment.json` (solo
placeholders, sin secretos).

## Verificacion

```powershell
Get-Content $env:USERPROFILE\.config\opencode\opencode.json | ConvertFrom-Json
Select-String -Path $env:USERPROFILE\.config\opencode\opencode.json -Pattern 'ctx7sk' -SimpleMatch
npm view @modelcontextprotocol/server-filesystem@2026.8.31 version
npm view @modelcontextprotocol/server-filesystem@2026.8.31 dist.shasum
Test-Path docs\mcp-filesystem.md
Test-Path examples\mcp\opencode-filesystem.fragment.json
opencode mcp list
# `read` fuera de la raiz debe devolver DENEGADO.
```
