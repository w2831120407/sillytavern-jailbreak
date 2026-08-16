# SillyTavern 破限使用指南

## 概念澄清

「破限」在酒馆圈子里有两个含义（来源：gtss-ai-docs）：

1. **对话补全预设（Preset）**：包含完整提示词、指令模板、采样参数的 JSON 文件，导入后整体生效。大多数人口中的"下载破限"指这个。
2. **破限开关 / 越狱提示词（Jailbreak Prompt）**：预设里的一个独立开关和提示词槽位，专门用来"破除"模型的道德限制。

**没有通吃所有模型的预设**——不同 LLM 的输入格式、系统提示方式、审查程度都不同，选预设必须先对模型。

## 破限提示词放在哪（三个槽位）

| 槽位 | 位置 | 作用 | 优先级 |
|---|---|---|---|
| **主提示词 Main Prompt** | 预设 → Prompt Manager | 全局破限，所有角色生效 | 中 |
| **越狱提示词 Jailbreak Prompt** | 预设 → AI Response Configuration | 专门的破限槽位，有独立开关 | 高 |
| **历史后指令 PHI** | 高级格式化 / Prompt Manager | 每次生成前最后注入，覆盖力最强 | 最高 |
| **角色卡 jailbreak 字段** | 角色卡高级选项 | 只对当前角色生效，替换全局破限 | 按卡 |

- 如果角色卡里写了 system prompt 且启用了「优先使用角色提示词」，会**覆盖全局主提示词**（常见"破限没生效"的原因）。
- PHI 需要开启「启用系统提示词」开关才会生效（即使系统提示词为空）。

## 导入对话补全预设（JSON）

1. 酒馆顶部菜单点 **API 图标** → 把 API 模式设为「聊天补全（Chat Completion）」。
2. 点 **预设图标**（AI Response Configuration）→ 点 **导入** 按钮，选择下载的破限预设 JSON。
3. 导入后在预设下拉菜单里选中它。
4. 若作者附带了正则文件，到 **扩展 → 正则** 里导入（一般选全局正则）。
5. 勾选「解锁上下文长度」，把最大回复长度设为模型输出上限（Gemini 8192 / Claude 4096 / 其他按模型）。

## 破限开关怎么开/关（新版酒馆）

- 导入破限预设后，AI Response Configuration 界面会出现几个**开关按钮**（破限相关模块）。
- 开关**移到右侧且变成蓝色/彩色 = 开启**；**灰色 = 关闭**。
- 点不了就多点几次或刷新；有些预设的开关本身是个"使用说明"块——**注意：使用说明不能开启**，开了会把说明当提示词发给 AI。
- 每个开关可以点编辑查看说明，按需开关。

## 常见问题排查

| 现象 | 原因 | 解决 |
|---|---|---|
| 破限没生效，模型照常拒绝 | 角色卡 system prompt 覆盖了全局 main | 关掉「优先使用角色提示词」，或把破限写进角色卡的 jailbreak 字段 |
| 开了破限但模型出戏/崩人设 | temperature 太高 / 破限缺少 RP 规范 | 压到 0.8-0.9，换完整版（含 RP 规范部分） |
| 回复被截断 | max tokens 太小 / 模型输出上限低 | 调大最大回复长度 |
| 空回复 / AI 道歉 | 预设与模型不匹配 | 换对应模型的预设（DeepSeek 用 DeepSeek 预设，Gemini 用 Gemini 预设） |
| 越狱开关是灰的 | 没选中对应预设 / 界面卡了 | 重新选中预设，刷新界面 |

## 参考来源

- SillyTavern 官方文档：https://docs.sillytavern.app/usage/prompts/ （Prompt 结构、主提示词、PHI）
- SillyTavern 中文文档：https://sillytavern.wiki/usage/prompts/context-template/ （上下文模板、宏）
- 艾萝工坊导入教程：https://www.erocraft.com/docs/sillytavern/05-presets
- 破限开关说明（飞书）：https://docs.feishu.cn/v/wiki/UiFLwxbiHimBH4k8oAHcD8vDnLg/aa
- Prompt 装配透视台（排查"为什么没生效"）：https://foreverse.app/zh/labs/prompt-assembly
