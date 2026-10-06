# Propaga el cuerpo canonico de .opencode/agents a las demas plataformas.
# Conserva el frontmatter propio de cada plataforma y solo sustituye el cuerpo.
# Uso: powershell -NoProfile -ExecutionPolicy Bypass -File tools/sync-agents.ps1
#      ./tools/sync-agents.ps1  (git-bash / Linux / macOS con pwsh)
$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$Agents = @("coordinator", "planner", "cybersecurity", "implementer", "reviewer", "start")

function Split-Frontmatter($Path) {
  $lines = Get-Content $Path
  if ($lines.Count -eq 0 -or $lines[0] -ne "---") {
    return @{ Front = ""; Body = (($lines -join "`n")).Trim() }
  }
  $idx = @()
  for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -eq "---") { $idx += $i; if ($idx.Count -eq 2) { break } }
  }
  if ($idx.Count -lt 2) { throw "Sin frontmatter valido: $Path" }
  return @{
    Front = ($lines[0..$idx[1]] -join "`n")
    Body  = (($lines[($idx[1] + 1)..($lines.Count - 1)] -join "`n")).Trim()
  }
}

function Get-CanonicalBody($Name) {
  $parts = Split-Frontmatter (Join-Path $Root ".opencode/agents/$Name.md")
  return $parts.Body
}

$Targets = @(
  @{ Platform = "claude";  Path = { param($n) ".claude/agents/$n.md" };        Header = ''; Footer = '' },
  @{ Platform = "cursor";  Path = { param($n) ".cursor/agents/$n.md" };        Header = ''; Footer = 'Uso en Cursor: invoca con @$n.' },
  @{ Platform = "vscode";  Path = { param($n) ".github/agents/$n.agent.md" };   Header = ''; Footer = '' },
  @{ Platform = "codex";   Path = { param($n) "codex/prompts/$n.md" };         Header = '# Actua como $n (Codex)`n`nCodex actua como agente unico: sigue este rol y el flujo de AGENTS.md.'; Footer = 'Ver `codex/workflow.md` para el paso a paso por fases.' }
)

foreach ($agent in $Agents) {
  $body = Get-CanonicalBody $agent
  foreach ($t in $Targets) {
    $rel = & $t.Path $agent
    # Sustituye la variable $n dentro de Header/Footer
    $n = $agent
    $header = $ExecutionContext.InvokeCommand.ExpandString($t.Header)
    $footer = $ExecutionContext.InvokeCommand.ExpandString($t.Footer)
    $full = Join-Path $Root $rel
    $parts = Split-Frontmatter $full
    $newBody = $body
    if ($header -ne "") { $newBody = $header + "`n`n" + $newBody }
    if ($footer -ne "") { $newBody = $newBody + "`n`n" + $footer }
    if ($parts.Front -ne "") { $out = $parts.Front + "`n`n" + $newBody + "`n" }
    else { $out = $newBody + "`n" }
    Set-Content $full $out
    Write-Host "sync [$($t.Platform)] $rel"
  }
}
Write-Host "done."
