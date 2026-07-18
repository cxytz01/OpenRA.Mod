# Sardaukar Reinforcements（Corrino → Harkonnen）— 需求文档

## 概述

Corrino 向 Harkonnen 提供 Sardaukar 增援。玩家拥有 `palace.corrino` 后，定时（2313 ticks ≈ 1:33）从 palace 出口自动生产 5 个单位：1 辆 bombardment_tank + 4 个 sardaukar（含 level 1/2/3 + 基础型）。单位从 palace Exit 走出，引擎自动处理 RallyPoint。无 faction 限制。

---

## 1. 触发与生命周期

| 事项 | 说明 |
|---|---|
| 触发条件 | player 至少有一个存活的 `palace.corrino` |
| 检测 | `Tick()` 每 2 秒调 `DetectSardaukarReinforcements()`，扫描 `ActivePlayers` |
| 启动 | 首次检测到 → `StartSardaukarReinforcements(player)` → 立即生产第一批 + 启动 2313 tick 循环 |
| 停止 | 循环内 palace 列表为空 → `SardaukarReinforcements[name] = nil` |
| 恢复 | palace 丢失后重新获得 → Tick 扫描再次触发 |
| 并发保护 | `SardaukarReinforcements[internalName]` 标志位 |

---

## 2. 生产机制

`palace.Produce(unitType, nil, "Sardaukar")` — 直接从 palace 生产，走 `Production.DoProduction`，与点击建造效果一致。单位以 `Trigger.AfterDelay(i - 1, ...)` 逐帧排队，避免同 tick 出口堵塞。

**要求**：生产的 actor 必须有 `Buildable` trait（`palace.Produce` 内部检查），增援专属 unit 用 `Prerequisites: ~disabled` 锁定建造但保留 Buildable。

**通知**：`Media.PlaySpeechNotification(player, "Reinforce")`，在 production 循环前调用一次。

---

## 3. Palace 选择

1. Primary（`IsPrimaryBuilding == true`）优先
2. 无 primary 时 `Utils.Random` 随机选一个存活 palace

---

## 4. 出口与 RallyPoint

Palace 在 `rules/structures.yaml` 中配置：
- `Exit@1/2/3` — `ExitCell: 1,3 / 2,3 / 3,3`（footprint 外下侧）
- `Production@Sardaukar: Produces: Sardaukar` — 匹配 `Produce()` 第三参数
- `RallyPoint` — 引擎自动处理，单位走出后自动 Move

---

## 5. 单位

| 单位 | 来源 | 备注 |
|---|---|---|
| `bombardment_tank` | `rules/vehicles.yaml`（已存在） | 导弹坦克 |
| `sardaukar` | `rules/infantry.yaml` | 基础 Sardaukar |
| `sardaukar.level1/2/3` | `rules/infantry.yaml` | 分别带 `InitialLevels: 1/2/3`，`Prerequisites: ~disabled` |

共 5 个单位，`Produce()` 按数组顺序依次生产。

---

## 6. 文件组织

| 文件 | 内容 |
|---|---|
| `harkonnen_reinforcements.lua` | 全部逻辑（`SpawnSardaukarReinforcements`、`StartSardaukarReinforcements`、`DetectSardaukarReinforcements`） |
| `scripts.lua` | `Tick()` 中调用 `DetectSardaukarReinforcements()` |
| `rules/structures.yaml` | `palace.corrino`：Exit、Production@Sardaukar、RallyPoint |
| `rules/infantry.yaml` | `sardaukar.level1/2/3` |
| `rules/world.yaml` | `Scripts:` 加 `harkonnen_reinforcements.lua` |

---

## 7. 常量

- `SardaukarInterval = 2313`（≈1:33）
- `SardaukarReinforcements = {}` — 并发保护标志位
- `SardaukarUnits = {"bombardment_tank", "sardaukar", "sardaukar.level1", "sardaukar.level2", "sardaukar.level3"}`

---

## 8. 边界情况

| 情况 | 处理 |
|---|---|
| 无 palace | 跳过检测；循环内 `SardaukarReinforcements[name] = nil` |
| palace 在生产期间被摧毁 | `Produce()` 内部 `WaitFor` 检测 actor 存活 |
| 所有出口被堵 | `Produce()` 内部 `WaitFor` 等待 |
| 多 palace | primary 优先，无则随机 |
| palace 被 capture | 下一 Tick 检测到不属于本玩家 → 终止 |
| 重建 palace | Tick 扫描重新触发 |

---

## 9. 不做什么

- **不** 使用 SupportPower — timer 循环，无需手动点击
- **不** 限制 faction — 任何拥有 `palace.corrino` 的玩家均可
- **不** 边缘探测 — 单位从 palace 出口走出
- **不** 改动 C# — 纯 Lua + YAML
