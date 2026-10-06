# Selective installer (Windows PowerShell)
# Examples:
#   .\install.ps1 -List
#   .\install.ps1 -Platform claude -TargetDir C:\proj\myapp
#   .\install.ps1 -Platform cursor,vscode -TargetDir C:\proj\myapp
#   .\install.ps1 -Platform opencode,claude -Global
#   .\install.ps1 -Platform all -TargetDir C:\proj\myapp
param(
  [string[]]$Platform = @("all"),
  [string]$TargetDir = ".",
  [switch]$Global,
  [switch]$List,
  [switch]$Help
)

$ErrorActionPreference = "Stop"
$SrcDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Show-Usage {
  Write-Host "Usage: .\install.ps1 [-Platform opencode,claude,cursor,vscode,codex,all] [-TargetDir PATH] [-Global] [-List] [-Help]"
}

function Show-List {
  Write-Host "opencode: .opencode/agents/*.md + AGENTS.md"
  Get-ChildItem (Join-Path $SrcDir ".opencode\agents\*.md")
  Write-Host "--- claude: .claude/agents/*.md"
  Get-ChildItem (Join-Path $SrcDir ".claude\agents\*.md")
  Write-Host "--- cursor: .cursor/agents/*.md + .cursor/rules/*.mdc + AGENTS.md"
  Get-ChildItem (Join-Path $SrcDir ".cursor\agents\*.md")
  Get-ChildItem (Join-Path $SrcDir ".cursor\rules\*.mdc")
  Write-Host "--- vscode: .github/agents/*.agent.md"
  Get-ChildItem (Join-Path $SrcDir ".github\agents\*.agent.md")
  Write-Host "--- codex: AGENTS.md + codex/prompts/*.md + codex/workflow.md"
  Get-ChildItem (Join-Path $SrcDir "codex\prompts\*.md")
  Get-ChildItem (Join-Path $SrcDir "codex\workflow.md")
}

function Install-Project($p, $dest) {
  switch ($p) {
    "opencode" {
      New-Item -ItemType Directory -Force -Path (Join-Path $dest ".opencode\agents") | Out-Null
      Copy-Item -Force (Join-Path $SrcDir ".opencode\agents\*.md") (Join-Path $dest ".opencode\agents\")
      if (-not (Test-Path (Join-Path $dest "AGENTS.md"))) { Copy-Item -Force (Join-Path $SrcDir "AGENTS.md") (Join-Path $dest "AGENTS.md") }
    }
    "claude" {
      New-Item -ItemType Directory -Force -Path (Join-Path $dest ".claude\agents") | Out-Null
      Copy-Item -Force (Join-Path $SrcDir ".claude\agents\*.md") (Join-Path $dest ".claude\agents\")
      if (-not (Test-Path (Join-Path $dest "AGENTS.md"))) { Copy-Item -Force (Join-Path $SrcDir "AGENTS.md") (Join-Path $dest "AGENTS.md") }
    }
    "cursor" {
      New-Item -ItemType Directory -Force -Path (Join-Path $dest ".cursor\agents") | Out-Null
      New-Item -ItemType Directory -Force -Path (Join-Path $dest ".cursor\rules") | Out-Null
      Copy-Item -Force (Join-Path $SrcDir ".cursor\agents\*.md") (Join-Path $dest ".cursor\agents\")
      Copy-Item -Force (Join-Path $SrcDir ".cursor\rules\*.mdc") (Join-Path $dest ".cursor\rules\")
      if (-not (Test-Path (Join-Path $dest "AGENTS.md"))) { Copy-Item -Force (Join-Path $SrcDir "AGENTS.md") (Join-Path $dest "AGENTS.md") }
    }
    "vscode" {
      New-Item -ItemType Directory -Force -Path (Join-Path $dest ".github\agents") | Out-Null
      Copy-Item -Force (Join-Path $SrcDir ".github\agents\*.agent.md") (Join-Path $dest ".github\agents\")
      if (-not (Test-Path (Join-Path $dest "AGENTS.md"))) { Copy-Item -Force (Join-Path $SrcDir "AGENTS.md") (Join-Path $dest "AGENTS.md") }
    }
    "codex" {
      if (-not (Test-Path (Join-Path $dest "AGENTS.md"))) { Copy-Item -Force (Join-Path $SrcDir "AGENTS.md") (Join-Path $dest "AGENTS.md") }
      New-Item -ItemType Directory -Force -Path (Join-Path $dest "codex\prompts") | Out-Null
      Copy-Item -Force (Join-Path $SrcDir "codex\prompts\*.md") (Join-Path $dest "codex\prompts\")
      Copy-Item -Force (Join-Path $SrcDir "codex\workflow.md") (Join-Path $dest "codex\workflow.md")
    }
  }
  Write-Host "installed [$p] -> $dest"
}

function Install-Global($p) {
  switch ($p) {
    "opencode" {
      $d = Join-Path $env:USERPROFILE ".config\opencode\agents"
      New-Item -ItemType Directory -Force -Path $d | Out-Null
      Copy-Item -Force (Join-Path $SrcDir ".opencode\agents\*.md") $d
      Write-Host "installed [$p] -> $d"
    }
    "claude" {
      $d = Join-Path $env:USERPROFILE ".claude\agents"
      New-Item -ItemType Directory -Force -Path $d | Out-Null
      Copy-Item -Force (Join-Path $SrcDir ".claude\agents\*.md") $d
      Write-Host "installed [$p] -> $d"
    }
    "cursor" {
      $d = Join-Path $env:USERPROFILE ".cursor\agents"
      New-Item -ItemType Directory -Force -Path $d | Out-Null
      Copy-Item -Force (Join-Path $SrcDir ".cursor\agents\*.md") $d
      Write-Host "installed [$p] -> $d"
      Write-Host "note: copy .cursor/rules/*.mdc + AGENTS.md per project for full workflow"
    }
    "vscode" {
      $d = Join-Path $env:USERPROFILE ".copilot\agents"
      New-Item -ItemType Directory -Force -Path $d | Out-Null
      Copy-Item -Force (Join-Path $SrcDir ".github\agents\*.agent.md") $d
      Write-Host "installed [$p] -> $d"
    }
    "codex" {
      $d = Join-Path $env:USERPROFILE ".codex"
      New-Item -ItemType Directory -Force -Path $d | Out-Null
      Copy-Item -Force (Join-Path $SrcDir "AGENTS.md") (Join-Path $d "AGENTS.md")
      Write-Host "installed [$p] -> $d\AGENTS.md"
      Write-Host "note: codex prompts are manual, see codex/workflow.md"
    }
  }
}

if ($Help) { Show-Usage; exit 0 }
if ($List) { Show-List; exit 0 }

$expanded = @()
foreach ($p in $Platform) {
  if ($p -eq "all") { $expanded += @("opencode","claude","cursor","vscode","codex") }
  else { $expanded += $p }
}

foreach ($p in $expanded) {
  if ($Global) { Install-Global $p } else { Install-Project $p $TargetDir }
}
Write-Host "done."
