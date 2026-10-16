# Verifica que el cuerpo canonico (.opencode) esta presente en cada plataforma.
$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$Agents = @("coordinator", "planner", "cybersecurity", "implementer", "reviewer", "start")

function Strip-Front($Text) {
  return ($Text -replace '(?s)\A---.*?---\s*', '').Trim()
}

$ok = $true
foreach ($n in $Agents) {
  $canon = Strip-Front (Get-Content (Join-Path $Root ".opencode/agents/$n.md") -Raw)
  $checks = @(
    (Join-Path $Root ".claude/agents/$n.md"),
    (Join-Path $Root ".cursor/agents/$n.md"),
    (Join-Path $Root ".github/agents/$n.agent.md"),
    (Join-Path $Root "codex/prompts/$n.md")
  )
  foreach ($f in $checks) {
    $body = Strip-Front (Get-Content $f -Raw)
    if (-not $body.Contains($canon)) { Write-Host "DIVERGE: $f"; $ok = $false }
  }
}
function Assert-FlujoContinuo {
  $pairs = @(
    @{ Name = "ID de corrida"; Pattern = "ID de corrida" },
    @{ Name = "Flujo continuo"; Pattern = "Flujo continuo" },
    @{ Name = "unico enrutador"; Pattern = "nico enrutador" }
  )
  foreach ($p in $pairs) {
    $hits = Select-String -Path (Join-Path $Root ".opencode/agents/*.md") -Pattern $p.Pattern -SimpleMatch -Encoding utf8
    if (-not $hits) { Write-Host ("FALTA cadena: " + $p.Name); $script:ok = $false }
  }
}
Assert-FlujoContinuo
if ($ok) { Write-Host "verify OK: 6 agentes x 5 plataformas contienen el cuerpo canonico" }
else { exit 1 }
