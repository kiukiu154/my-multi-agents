# Instalacion rapida: descarga el repo desde GitHub y delega en tools/install/install.ps1.
# Uso normal (una linea en la terminal del IDE, situado en tu proyecto):
#   iex (irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.ps1)
# Solo una plataforma:
#   $env:AGENTS_PLATFORM="claude"; iex (irm https://raw.githubusercontent.com/kiukiu154/my-multi-agents/main/tools/install/quick-install.ps1)
param(
  [string]$Platform = $(if ($env:AGENTS_PLATFORM) { $env:AGENTS_PLATFORM } else { "all" }),
  [string]$TargetDir = ".",
  [ValidatePattern('^[A-Za-z0-9._-]+$')]
  [string]$Ref = "main"
)
$ErrorActionPreference = "Stop"
$allowed = @("opencode","claude","cursor","vscode","codex","all")
foreach ($x in $Platform.Split(",") | ForEach-Object { $_.Trim().ToLower() } | Where-Object { $_ }) {
  if ($allowed -notcontains $x) { throw "plataforma desconocida: $x (usa: opencode, claude, cursor, vscode, codex, all)" }
}
$tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("agents-" + [Guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
try {
  $zip = Join-Path $tmp "repo.zip"
  Invoke-RestMethod "https://github.com/kiukiu154/my-multi-agents/archive/refs/heads/$Ref.zip" -OutFile $zip
  $x = Join-Path $tmp "x"
  Expand-Archive $zip $x
  $src = Join-Path $x "my-multi-agents-$Ref"
  & (Join-Path $src "tools/install/install.ps1") -Platform $Platform.Split(",") -TargetDir $TargetDir
}
finally {
  Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
}
Write-Host "quick install done: $Platform -> $TargetDir"
