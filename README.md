# SillyTavern 通用破限提示词技能 — 安装说明

> 📦 GitHub 仓库：https://github.com/w2831120407/sillytavern-jailbreak

一套技能包，三个平台通用（都遵循标准 Agent Skills 规范：目录 + `SKILL.md`，YAML frontmatter 含 `name`/`description`）。

## 快速安装（Windows）

```powershell
# 技能包源目录
$src = "$env:USERPROFILE\.openclaw\workspace\skills\sillytavern-jailbreak"

# 1) OpenClaw
Copy-Item $src "$env:USERPROFILE\.openclaw\skills\sillytavern-jailbreak" -Recurse -Force

# 2) TRAE（全局技能）
New-Item -ItemType Directory -Force "$env:USERPROFILE\.trae\skills" | Out-Null
Copy-Item $src "$env:USERPROFILE\.trae\skills\sillytavern-jailbreak" -Recurse -Force

# 3) Codex（用户级技能）
New-Item -ItemType Directory -Force "$env:USERPROFILE\.agents\skills" | Out-Null
Copy-Item $src "$env:USERPROFILE\.agents\skills\sillytavern-jailbreak" -Recurse -Force
```

或：项目级使用 `Codex`/`TRAE` 时，把技能包放进仓库的 `.agents/skills/`（Codex 会从 CWD 向上扫描到仓库根）。

## 各平台生效方式

| 平台 | 路径 | 生效方式 |
|---|---|---|
| **OpenClaw** | `~/.openclaw/skills/sillytavern-jailbreak/` | 重启/重载会话后自动发现，技能描述命中"破限/越狱/jailbreak"等词时触发 |
| **TRAE** | `~/.trae/skills/sillytavern-jailbreak/` | 设置 → 规则与技能 → 技能 面板里刷新；全局技能出现在 Global 标签下 |
| **Codex** | `~/.agents/skills/sillytavern-jailbreak/` | `codex` 启动时自动发现（用户级）；或放项目 `.agents/skills/` 作为仓库级 |

TRAE 还支持项目级 `.trae/skills/`；Codex 支持 `.agents/skills/`（需在 TRAE 设置里开启该目录开关）。

## 触发方式（对任意平台的 AI 说）

- 「用 sillytavern-jailbreak 技能给我生成一份 DeepSeek 的破限提示词」
- 「给我一个通用破限，我模型是 MiMo」
- 「破限没生效，帮我排查」
- 技能被加载后，AI 会按 `SKILL.md` 流程给出提示词 + 放置指南 + 调参建议。

## 文件结构

```
sillytavern-jailbreak/
├── SKILL.md                          # 技能入口（何时用/流程/核心结构）
├── README.md                         # 本文件
├── references/
│   ├── universal-jailbreak-zh.md     # ★ 中文通用破限（完整版/精简版/PHI版/卡级模板）
│   ├── universal-jailbreak-en.md     # 英文版 + 抗拒绝锚点
│   ├── model-notes.md                # 各模型适配 + 调参 + 失效对策
│   └── sillytavern-guide.md          # 槽位/预设导入/破限开关/排查
└── templates/
    └── character-prompt-template.md  # 角色卡组合式破限模板
```

## 来源与致谢

调研整理自（2026-08 检索）：
- [Acmesec/PromptJailbreakManual](https://github.com/Acmesec/PromptJailbreakManual) — 越狱框架方法论（DAN / Mongo Tom / CO-STAR）
- [elder-plinius/L1B3RT4S](https://github.com/elder-plinius/L1B3RT4S) — LIBeRTAS 旗舰模型越狱库
- [ShadowHackrs/Jailbreaks-GPT-Gemini-deepseek-](https://github.com/ShadowHackrs/Jailbreaks-GPT-Gemini-deepseek-) — DeepSeek 适配 + ENI 抗注入协议
- [gtss-ai-docs](https://gtss-ai-docs.barz.foo/chatting/sillytavern/get_preset.html) — "破限=对话补全预设"概念
- [SillyTavern 官方/中文文档](https://sillytavern.wiki)、[艾萝工坊](https://www.erocraft.com/docs/sillytavern/05-presets)、[DeepSeek Tavern 文档](https://docs.deepseektavern.com/preset-guide.html)

本技能中的提示词为基于上述资料的**自研组合**（叙事引擎框架 + 抗注入协议 + RP 规范），非原样搬运。

## 免责

仅用于虚构创作与角色扮演。使用前请确认符合所用模型服务商的服务条款。
