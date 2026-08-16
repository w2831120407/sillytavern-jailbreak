# ============================================================
# sillytavern-jailbreak 技能一键安装脚本（Windows）
# 用法:  powershell -ExecutionPolicy Bypass -File install.ps1
# 作用:  复制技能包到 OpenClaw / TRAE / Codex 三个平台
# ============================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = 'Stop'

# 技能包所在目录（本脚本所在目录）
$src = $PSScriptRoot
if (-not (Test-Path "$src\SKILL.md")) { throw "未找到 SKILL.md，请把脚本放在技能包根目录运行" }

# 安装目标（按平台）
$targets = @(
    @{ Name = 'OpenClaw'; Path = "$env:USERPROFILE\.openclaw\skills\sillytavern-jailbreak" },
    @{ Name = 'TRAE';     Path = "$env:USERPROFILE\.trae\skills\sillytavern-jailbreak" },
    @{ Name = 'Codex';    Path = "$env:USERPROFILE\.agents\skills\sillytavern-jailbreak" }
)

foreach ($t in $targets) {
    $parent = Split-Path $t.Path -Parent
    New-Item -ItemType Directory -Force $parent | Out-Null
    if (Test-Path $t.Path) {
        Copy-Item "$src\*" $t.Path -Recurse -Force
        Write-Output "[$($t.Name)] 已更新 -> $($t.Path)"
    } else {
        Copy-Item $src $t.Path -Recurse
        Write-Output "[$($t.Name)] 已安装 -> $($t.Path)"
    }
}

Write-Output ""
Write-Output "安装完成！生效方式："
Write-Output "  - OpenClaw: 重载会话 / 重启网关后自动发现技能"
Write-Output "  - TRAE:     设置 -> 规则与技能 -> 技能，刷新后出现在 Global 标签"
Write-Output "  - Codex:    重新启动 codex 后自动发现（用户级技能）"
Write-Output ""
Write-Output "⚠️ TRAE 注意：内置模型会拒绝破限类创作，必须配置自定义模型 API 才有效，"
Write-Output "   详见 PLATFORM-ADAPTATION.md"
