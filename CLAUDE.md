# YAML 操作规范

## 数据结构

所有 YAML 修改必须严格使用 `G:\prj\OpenRA-Hacking\OpenRA-release-20250330` 的数据结构。操作前必须 Read 该目录中的对应文件。

## 修改流程

1. Read 目标 YAML 文件全文
2. 备份：Copy-Item 目标文件到同目录，加 `.bak` 后缀
3. Read `OpenRA-release-20250330` 中对应的源代码或 YAML 基准，确认字段名、默认值、继承链
4. 使用 `Write` 直接写入完整文件内容（替代 C# MiniYaml 修改、写回 YAML）
5. 验证：Read 修改后的区域，确认缩进正确、相邻节点未被破坏

## 修改前必读

**每次**执行修改前，必须重新 Read 待改的目标文件。即使该文件在之前步骤中已读过，也不允许依赖旧快照——用户可能在你上次读取后手动修改了文件内容。

## MiniYaml 使用禁区

- **禁止** `new MiniYaml(rawString)` 构造函数创建多行嵌套节点 — 会产生不可控的缩进
- **禁止** `discardCommentsAndWhitespace: true` + `WriteToFile` — 会删除所有注释和空行
- 如需使用 MiniYaml，必须用 `new MiniYamlNode(key, new MiniYaml(value))` 逐节点构造

## 强制：每次修改后自动检查打包

任何 Write 写回文件后，**必须**作为最后一个动作执行 `Bash: cd "G:/prj/OpenRA-Hacking/Mods" && python check_and_pack.py`，并明确报告结果。在打包完成前不得解释改动内容。

## 禁止

- `sed`
- Python（`python check_and_pack.py` 除外）
- `Edit`
- `awk`
- `PowerShell` 用于修改文件内容
- "根因"
- "可能"
- 不备份直接修改

## 允许

- `Write` — 写入完整文件内容
- `PowerShell` 仅用于 `Copy-Item` 文件复制备份

## 强制：多行修改必须用 Write 写完整文件

**任何超过 1 行的修改**（包括新增、删除、调整缩进），必须使用 `Write` 写回完整文件内容。流程：

1. `Read` 目标文件全文
2. 在输出中构造完整的新文件内容
3. `Write` 一次性写入

此规则同时适用于 `.yaml` 和 `.lua` 文件。

**禁止**用 `PowerShell` 逐行拼接、正则替换、数组插入等方式修改 tab 缩进文件。**禁止**用 `sed`、`awk` 做任何文件修改。这些工具无法验证不可见字符（tab/空格）的正确性，每次都会产生缩进错误，修复耗时远超写完整文件。
