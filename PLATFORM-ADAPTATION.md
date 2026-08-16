# 平台适配说明（TRAE / OpenClaw / Codex）

技能包本体是标准 Agent Skills（`SKILL.md` + YAML frontmatter），三平台通用。
本文说明各平台的特殊适配点。

---

## 🟢 OpenClaw 适配

### 安装
- 全局技能目录：`~/.openclaw/skills/sillytavern-jailbreak/`（本仓库 `install.ps1` 会自动安装）
- 安装后**重载会话或重启网关**才会被技能系统发现。

### 触发方式
技能描述（frontmatter `description`）包含触发词：`破限 / 越狱 / jailbreak / 解除内容限制 / 无限制角色扮演 / 让模型不拒绝敏感虚构创作`。
直接对星弥（或任意 OpenClaw agent）说：
- 「用破限技能给我生成一份 DeepSeek 的破限提示词」
- 「破限没生效，帮我排查」
- 「写一段不拒绝的虚构创作，上 NSFW 组合」

### 使用效果
OpenClaw 接的是用户自有的 DeepSeek / MiMo API，**系统提示层可自由注入**，破限提示词真实生效（比 TRAE 内置模型有效得多）。遇到拒绝时按 `references/model-notes.md` 的失效对策迭代，或切换模型（DeepSeek 中文 RP 最稳，MiMo 支持 thinking）。

### 特别说明
- OpenClaw 技能内容是作为指令上下文注入的，模型会「遵循」技能里的提示词；技能本身不是系统提示词替换，而是让 agent 按流程产出可用的破限提示词文本。
- 想让「破限状态」直接作用于对话：把 `references/universal-jailbreak-zh.md` 的完整版提示词作为对话开场 system 内容即可。

---

## 🟠 TRAE 适配

### 安装
- 全局技能目录：`%USERPROFILE%\.trae\skills\sillytavern-jailbreak\`（install.ps1 自动安装）
- 打开 TRAE：**设置 → 规则与技能 → 技能**，刷新后技能出现在 **Global** 标签下。
- 项目级用法：把技能包放进项目的 `.trae/skills/` 或 `.agents/skills/`（需在设置中开启 `.agents/skills` 目录开关）。

### ⚠️ 关键限制：内置模型无法破限
TRAE 内置模型（字节系）在**模型对齐 + 平台审核**层强制拒绝破限类创作，技能无法改变它的内容底线（会回复"技能本身不改变我的内容底线"）。这是平台行为，不是配置问题。

**要让技能在 TRAE 里生效，必须配置自定义模型：**

| 项 | DeepSeek | 小米 MiMo |
|---|---|---|
| Base URL | `https://api.deepseek.com` | `https://api.xiaomimimo.com/v1` |
| 模型名 | `deepseek-chat`（推理用 `deepseek-reasoner`） | `mimo-v2.5-pro`（或套餐实际型号） |
| API Key | `sk-...` | `sk-...`（两种认证头都支持） |

- 认证头 TRAE 自动加 `Authorization: Bearer`，MiMo 兼容。
- ⚠️ MiMo 别填 `https://api.xiaomimimo.com/anthropic`——那是 Anthropic 格式，TRAE 按 OpenAI 格式发会报错。
- 配置后让 TRAE 使用该模型发起对话，再触发技能。

### 报错排查（自定义 API 后仍报错）
1. **看报错类型**：
   - `400/401/404/model not found` → 配置问题（端点/模型名/key），对照上表检查
   - 「内容违反安全规定」类拦截 → TRAE 客户端/网关层审核，**此路不通**，换 OpenClaw/SillyTavern
   - 模型正常回复但说"我不能" → 提示词没生效，用完整版 + PHI，或换 MiMo/DeepSeek
2. **30 秒直连对比**：在 TRAE 外用 curl 直连同一个 API + 同一提示词。外面能出内容而 TRAE 报错 → TRAE 层问题；外面也拒绝 → API/提示词问题。

### 建议
TRAE 定位是编程 IDE。破限创作（小说/角色扮演）建议用 OpenClaw（星弥）或 SillyTavern + 自有 API，TRAE 里别折腾。

---

## 🔵 Codex 适配（补充）

- 用户级技能：`~/.agents/skills/sillytavern-jailbreak/`（install.ps1 自动安装）
- 仓库级：放 `.agents/skills/`（Codex 从 CWD 向上扫描到仓库根）
- Codex 用 OpenAI 系模型（GPT-5.6 等），破限效果一般，建议配合 `references/universal-jailbreak-en.md` 英文版使用；或配置第三方 OpenAI 兼容 API。

---

## 快速决策表

| 平台 | 能否破限 | 需要什么 |
|---|---|---|
| OpenClaw（星弥） | ✅ 有效 | 自有 DeepSeek/MiMo API（已配好） |
| SillyTavern | ✅ 有效 | 自有 API / 本地模型 + 预设组合 |
| TRAE | ⚠️ 需自定义模型 | 自定义 OpenAI 兼容 API；客户端审核时无解 |
| Codex | ⚠️ 视模型 | 英文版提示词 / 第三方 API |
