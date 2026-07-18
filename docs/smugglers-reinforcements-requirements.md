# Ordos Reinforcements — 需求文档

## 概述

Ordos 通过 starport 接收定时空运增援。每隔 1876 ticks（≈2:05）从地图边缘由 carryall 运输一批单位到 starport RallyPoint 卸货，单位落地后 AttackMove。timer 驱动，无需手动点击。

非 ordos faction 捕获 ordos 玩家的 starport 后获得血统标记，同样触发增援。

---

## 1. 触发与生命周期

| 事项 | 说明 |
|---|---|
| 触发条件 | ordos faction + `upgrade.starport` + 存活 starport；或拥有 ordos 血统 starport |
| 检测 | `Tick()` 每 2 秒调 `DetectOrdosReinforcements()`，扫描 `ActivePlayers` |
| 启动 | 首次 qualified → `StartOrdosReinforcements(player)` → 立即运第一批 + 启动循环 |
| 停止 | 循环内 `PlayerQualifies` 返回 false → `OrdosReinforcements[name] = nil` |
| 恢复 | starport 丢失后重新获得 → Tick 扫描再次触发 |
| 并发保护 | `OrdosReinforcements[internalName]` 标志位 |

---

## 2. 生产机制

`Reinforcements.ReinforceWithTransport(player, "carryall.transport", group, path, { rallypoint, entryCell })`。

carryall 在边缘创建 → 装载单位 → 飞到 RallyPoint 卸货 → 飞回边缘销毁。`OnPassengerExited` 回调每个单位卸下后 `AfterDelay(1)` 稳定，然后 `AttackMove(rallypoint, 1)`（无 AttackMove 则 fallback `Move`）。

不要求 `Buildable` trait，与 `palace.Produce()` 不同。

通知：`Media.PlaySpeechNotification(player, "Reinforce")`，每次运送前播一次。

---

## 3. Starport 选择

1. Primary（`IsPrimaryBuilding`）优先
2. 无 primary 时 `Utils.Random` 随机选存活 starport

---

## 4. RallyPoint

`starport.RallyPoint`；nil 或落在 starport 自身 3×3 footprint 内时回退到 `sloc + (1,3)`。玩家可随时修改。

---

## 5. 血统标记

`OrdosOriginStarports = {["X,Y"] = true}`，key 为 starport 位置。

| 事件 | 行为 |
|---|---|
| capture | `OnCapture` → `oldOwner.HasPrerequisites({"upgrade.starport"})` → 标记 + 启动新 owner 增援 |
| 摧毁 | `OnRemovedFromWorld` → 清除标记 |
| 新建 | `Trigger.OnAnyProduction` → `produced.Type == "starport"` → 绑定 hooks |

**Qualification 两条路径**：
1. 自身是 ordos + `upgrade.starport` + 有 starport → qualified
2. 拥有 ordos 血统 starport（捕获来的）→ qualified

血统标记条件：`oldOwner.HasPrerequisites({"upgrade.starport"})`。`upgrade.starport` 仅 ordos 可研发，因此实际效果就是「捕获 ordos 玩家的 starport 后继承增援资格」。

---

## 6. 单位

两组随机：

| 组 | 内容 |
|---|---|
| A | light_inf × 10 + flamer × 1 |
| B | trooper × 5 + bison_tank × 1 |

全部复用已有 ordos 单位（`rules/infantry.yaml`、`rules/vehicles.yaml`），无需新增 YAML。

---

## 7. 文件组织

| 文件 | 内容 |
|---|---|
| `ordos_reinforcements.lua` | 全部逻辑：`InitOrdosReinforcements`、`DetectOrdosReinforcements`、`StartOrdosReinforcements`、`SpawnOrdosReinforcements`、`BindStarportHooks` |
| `scripts.lua` | `WorldLoaded` 中调 `InitOrdosReinforcements()`；`Tick()` 中调 `DetectOrdosReinforcements()` |
| `rules/structures.yaml` | `starport`：RallyPoint、PrimaryBuilding（已配置） |
| `rules/world.yaml` | `Scripts:` 加 `ordos_reinforcements.lua` |

---

## 8. 常量

- `OrdosInterval = 1876`（≈2:05）
- `OrdosReinforcements = {}` — 并发保护
- `OrdosOriginStarports = {}` — 血统标记

---

## 9. 边界情况

| 情况 | 处理 |
|---|---|
| 无 starport | `PlayerQualifies` → false，跳过/终止 |
| carryall 飞行中 starport 被摧毁 | `OnPassengerExited` 中 `pass.IsDead` guard |
| starport 被 capture | 原 owner 循环终止；新 owner 获血统标记 + 立即启动 |
| carryall 被击落 | `Reinforcements.ReinforceWithTransport` 返回 nil，`result ~= nil` guard |
| RallyPoint 在 footprint 内 | 回退 `sloc + (1,3)` |
| 多 starport | primary 优先，无则随机 |

---

## 10. 不做什么

- **不** 使用 SupportPower — timer 循环
- **不** 使用 `palace.Produce()` — starport 无 Production 队列
- **不** 边缘探测 — carryall 飞行无需地面寻路
- **不** 新增 YAML 单位
- **不** 改动 C#
