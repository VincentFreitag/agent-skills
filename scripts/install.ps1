<#
.SYNOPSIS
  Import skills from this library into a project's .claude/skills/.

.EXAMPLE
  .\scripts\install.ps1 -List
.EXAMPLE
  .\scripts\install.ps1 fable-mode, grill-me
.EXAMPLE
  .\scripts\install.ps1 -All -Target C:\dev\MyProject\.claude\skills

  Copies plain files you own and can edit. Re-run with -Force to update.
#>
# PositionalBinding=$false + an explicit Position on $Skills: without this, a bare
# `install.ps1 grill-me` binds "grill-me" to -Target instead of the skill list.
[CmdletBinding(PositionalBinding = $false)]
param(
  [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
  [string[]] $Skills = @(),
  [switch] $List,
  [switch] $All,
  [switch] $Force,
  [string] $Target = ".claude/skills"
)

$ErrorActionPreference = 'Stop'

# ValueFromRemainingArguments hands `a, b, c` over as the single string "a b c", so
# re-split on whitespace and commas before matching against the catalog.
$Skills = @($Skills | ForEach-Object { $_ -split '[,\s]+' } | Where-Object { $_ })

$LibRoot     = Split-Path -Parent $PSScriptRoot
$SkillsRoot  = Join-Path $LibRoot 'skills'
$LockName    = '.innohub-skills.lock'

function Get-Catalog {
  Get-ChildItem -Path $SkillsRoot -Directory |
    ForEach-Object {
      $category = $_.Name
      Get-ChildItem -Path $_.FullName -Directory |
        Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') } |
        ForEach-Object {
          $hit = Select-String -Path (Join-Path $_.FullName 'SKILL.md') `
                               -Pattern '^description:\s*(.*)$' | Select-Object -First 1
          $desc = if ($hit) { $hit.Matches.Groups[1].Value } else { '(no description)' }
          if ($desc.Length -gt 100) { $desc = $desc.Substring(0, 100) + '...' }
          [pscustomobject]@{
            Name        = $_.Name
            Category    = $category
            Path        = $_.FullName
            Description = $desc
          }
        }
    } | Sort-Object Name
}

$catalog = Get-Catalog

if ($List) {
  $catalog | Format-Table Name, Category, Description -AutoSize -Wrap
  return
}

if (-not $All -and $Skills.Count -eq 0) {
  Write-Host "Nothing to do. Pick skills, or use -All. Available:"
  $catalog | Format-Table Name, Category -AutoSize
  exit 1
}

$selected = if ($All) { $catalog } else { $catalog | Where-Object { $Skills -contains $_.Name } }

foreach ($want in $Skills) {
  if (-not ($catalog.Name -contains $want)) {
    Write-Warning "  ??    $want - no such skill in this library"
  }
}

# Native git failure sets $LASTEXITCODE rather than throwing, so catch isn't enough.
$commit = 'unknown'
$rev = & git -C $LibRoot rev-parse --short HEAD 2>$null
if ($LASTEXITCODE -eq 0 -and $rev) { $commit = "$rev".Trim() }
$stamp  = Get-Date -Format 'yyyy-MM-dd'

if (-not (Test-Path $Target)) { New-Item -ItemType Directory -Path $Target -Force | Out-Null }
$lockPath = Join-Path $Target $LockName
if (-not (Test-Path $lockPath)) { "# skill`tcommit`timported" | Out-File $lockPath -Encoding utf8 }

$installed = 0
foreach ($skill in $selected) {
  $dest = Join-Path $Target $skill.Name

  if ((Test-Path $dest) -and -not $Force) {
    Write-Host "  skip  $($skill.Name) (already present - pass -Force to overwrite)"
    continue
  }

  if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
  Copy-Item $skill.Path $dest -Recurse

  $lines = @(Get-Content $lockPath | Where-Object { $_ -notmatch "^$([regex]::Escape($skill.Name))`t" })
  $lines += "$($skill.Name)`t$commit`t$stamp"
  $lines | Out-File $lockPath -Encoding utf8

  Write-Host "  ok    $($skill.Name)  [$($skill.Category)]  @ $commit"
  $installed++
}

Write-Host ""
Write-Host "$installed skill(s) -> $Target (tracked in $LockName)"
Write-Host "Restart your agent session so it picks them up."
