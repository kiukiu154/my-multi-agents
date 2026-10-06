# Descarga suelta: baja solo la carpeta que necesites, sin instalar en ningun IDE.
# Ejemplos:
#   .\download.ps1 -Platform claude
#   .\download.ps1 -Platform cursor,vscode -OutDir "$env:USERPROFILE\Downloads\agents"
#   .\download.ps1 -Platform all
param(
  [string]$Platform = "claude",
  [string]$OutDir = "",
  [string]$Ref = "main"
)
$ErrorActionPreference = "Stop"

function Get-Needed($p) {
  switch ($p) {
    "opencode" { return @(".opencode/agents", "AGENTS.md") }
    "claude"   { return @(".claude/agents", "AGENTS.md") }
    "cursor"   { return @(".cursor/agents", ".cursor/rules", "AGENTS.md") }
    "vscode"   { return @(".github/agents", "AGENTS.md") }
    "codex"    { return @("codex/prompts", "codex/workflow.md", "AGENTS.md") }
    default { throw "plataforma desconocida: $p (usa: opencode, claude, cursor, vscode, codex, all)" }
  }
}

$list = @()
foreach ($p in $Platform.Split(",") | ForEach-Object { $_.Trim().ToLower() } | Where-Object { $_ }) {
  if ($p -eq "all") { $list += @("opencode","claude","cursor","vscode","codex") }
  else { $list += $p }
}
$list = $list | Select-Object -Unique

$tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("agents-dl-" + [Guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
try {
  $zip = Join-Path $tmp "repo.zip"
  Invoke-RestMethod "https://github.com/kiukiu154/my-multi-agents/archive/refs/heads/$Ref.zip" -OutFile $zip
  $x = Join-Path $tmp "x"
  Expand-Archive $zip $x
  $src = Join-Path $x "my-multi-agents-$Ref"

  foreach ($p in $list) {
    $dest = if ($OutDir) { Join-Path $OutDir $p } else { Join-Path (Get-Location) "downloads\$p" }
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    foreach ($rel in Get-Needed $p) {
      $from = Join-Path $src $rel
      if (Test-Path $from -PathType Container) {
        $to = Join-Path $dest $rel
        New-Item -ItemType Directory -Force -Path $to | Out-Null
        Copy-Item -Force -Recurse (Join-Path $from "*") $to
      } elseif (Test-Path $from -PathType Leaf) {
        $to = Join-Path $dest (Split-Path $rel -Parent)
        if ($to.TrimEnd("\","/") -ne $dest.TrimEnd("\","/") -and $to) { New-Item -ItemType Directory -Force -Path $to | Out-Null }
        Copy-Item -Force $from (Join-Path $dest $rel)
      }
    }
    Write-Host "descargado [$p] -> $dest"
  }
}
finally {
  Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
}
Write-Host "done."
