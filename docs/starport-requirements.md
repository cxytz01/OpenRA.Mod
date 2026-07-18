# Starport（CHOAM 市场）— 需求文档

## 概述

Starport 是 CHOAM 商团星港机制。玩家建造 starport 后，可通过 "Starport" 生产队列订购车辆和飞机。每个单位类型有独立库存上限和补充速率。订单累积到购物车（最多 6 件），手动确认后由 CHOAM 运输舰（`frigate_choam`）在 60 秒倒计时后送达，卸货到 starport RallyPoint，单位自动 AttackMove。

纯 carryall 订单跳过运输舰直接飞达。harvester 额外触发 `FindResources`。

本系统是 Ordos reinforcements 的基石 —— `PlayerQualifies` 中检查的 `upgrade.starport`、`PlayerHasAnyStarport()` 均依赖此 starport。

---

## 1. 触发与初始化

| 事项 | 说明 |
|---|---|
| 入口 | `scripts.lua` 的 `WorldLoaded` 调用 `InitStarport()` |
| 初始化 | 遍历 `ActivePlayers`，初始化 `StarportUnits`、`RevokeTokens`、`DummyActors` 空表；为预置 starport 调用 `InitStockForPlayer`；注册 `OnPlayerLost` 清理回调 |
| 事件驱动 | `Trigger.OnAnyProduction`：starport 建造 → `InitStockForPlayer`；生产队列为 `Starport` → `StarportDispatch` |
| 并发保护 | `shipment-in-progress` 条件防止重复下单 |

---

## 2. 库存系统

### 2.1 库存参数

| dummy | 对应单位 | 工厂队列 | BuildDuration (ticks) | 1工厂 (秒) | 2工厂 (秒) | 3工厂 (秒) | n (最大库存) | charge (秒) |
|---|---|---|---|---|---|---|---|---|
| dummy.harvester | harvester | Armor (heavy_factory) | 600 | 24.0 | 18.0 | 12.0 | 6 | 370 |
| dummy.trike | trike | Vehicle (light_factory) | 225 | 9.0 | 5.9 | 4.5 | 10 | 220 |
| dummy.raider | raider | Vehicle (light_factory) | 250 | 10.0 | 6.6 | 5.0 | 10 | 220 |
| dummy.quad | quad | Vehicle (light_factory) | 325 | 13.0 | 8.6 | 6.5 | 9 | 225 |
| dummy.heavy_quad | heavy_quad | Vehicle (light_factory) | 364 | 14.6 | 9.6 | 7.3 | 8 | 210 |
| dummy.dustrider | dustrider | Vehicle (light_factory) | 405 | 16.2 | 10.7 | 8.1 | 5 | 250 |
| dummy.combat_tank_a | combat_tank_a | Armor (heavy_factory) | 432 | 17.3 | 13.0 | 8.6 | 8 | 240 |
| dummy.combat_tank_h | combat_tank_h | Armor (heavy_factory) | 432 | 17.3 | 13.0 | 8.6 | 8 | 240 |
| dummy.combat_tank_o | combat_tank_o | Armor (heavy_factory) | 432 | 17.3 | 13.0 | 8.6 | 8 | 240 |
| dummy.siege_tank | siege_tank | Armor (heavy_factory) | 390 | 15.6 | 11.7 | 7.8 | 7 | 270 |
| dummy.missile_tank | missile_tank | Armor (heavy_factory) | 512 | 20.5 | 15.4 | 10.2 | 7 | 230 |
| dummy.mcv | mcv | Armor (heavy_factory) | 750 | 30.0 | 22.5 | 15.0 | 3 | 500 |
| dummy.carryall | carryall | Aircraft (high_tech_factory) | 750 | 30.0 | 22.5 | 15.0 | 4 | 400 |

每个单位独立库存。`n` 为上限，`charge` 为补充 1 件的间隔（秒）。

### 2.2 补充机制

`InitStockForPlayer` 将所有单位库存设为 `max`，为每个单位启动独立 recharge timer：每 `charge` 秒库存 +1（上限 `max`）。库存从 0 补到 1 时自动撤销 `stock-depleted-xxx` 条件。

### 2.3 消耗

`ConsumeStock(player, unitName)` → 库存 -1。库存归零时授予 `stock-depleted-xxx` 条件，触发 dummy 的 `Prerequisites: !stock-depleted-xxx` 使其不可订购。

### 2.4 查询

`HasStock(player, unitName)` 返回库存 > 0。

---

## 3. 订购流程

### 3.1 下单（Dummy → 购物车）

玩家在 "Starport" 队列中建造 `dummy.xxx`（如 `dummy.trike`），`Trigger.OnAnyProduction` 回调 `StarportDispatch` → `ExperimentalStarport`：

1. 检查 `shipment-in-progress` → 拒绝
2. `HasStock(player, unitName)` → 无库存则 `dummy.Destroy()` 并返回
3. `cartSize >= FrigateCapacity(6)` → 拒绝
4. `ConsumeStock` → 单位名加入 `StarportUnits[player]`
5. `dummy` 加入 `DummyActors[player]`
6. 授予 `order-N` 条件显示数量叠加图标
7. 购物车从空变非空 → 授予 `frigate-not-empty`
8. 购物车满（6 件）→ 授予 `frigate-full`（阻止继续下单）

**注意**：新增 `dummy.xxx` 类型时必须在 `StockConfig` 中加对应条目，否则 `HasStock` 始终返回 false。

### 3.2 Dummy Actor（`rules/starport.yaml`）

- `^starport_dummy`：继承基类，`Buildable.Queue: Starport`，`Prerequisites: ~starport, !frigate.full, !shipment-in-progress`
- 每个 `dummy.xxx`：Inherits `^starport_dummy`，额外 `Prerequisites: !stock-depleted-xxx`，`BuildPaletteOrder` 控制图标排列
- `^overlay_external_conditions`：提供 `order-1` 到 `order-6` 的外部叠加条件，DummyActors 上的同类型 dummy 累加计数

### 3.3 确认购买（purchase.starport）

玩家建造 `purchase.starport`，`StarportDispatch` 检测到后调用 `CHOAMDelivery`：

1. 检查 `shipment-in-progress` → 拒绝（防止重复）
2. 购物车为空 → `purchase.Destroy()` 返回
3. 授予 `shipment-in-progress` 条件
4. `DeliveryNotifications`：60 秒倒计时语音（T-5/4/3/2/1）
5. `AfterDelay(FrigateDeliveryDelay)` 后执行交货

---

## 4. 交货机制

### 4.1 Starport 选择

`SelectStarport(player)`：Primary 优先，否则 `Utils.Random` 随机选存活 starport。

### 4.2 RallyPoint

`GetRallyPoint(starport)`：`starport.RallyPoint`；nil 或落在 starport 自身 3×3 footprint 内时回退 `sloc + (1,3)`。

### 4.3 纯 Carryall 订单（无地面单位）

`Reinforcements.Reinforce(player, airUnits, path)` 直接创建 carryall，飞到 starport 附近。Trigger 监听所有 carryall 的 `OnIdle` / `OnRemovedFromWorld` → 全部到达或销毁后 `ResetStartport`。额外 `AfterDelay(FrigateDeliveryDelay)` 兜底超时重置。

### 4.4 地面单位订单

`Reinforcements.ReinforceWithTransport(player, "frigate_choam", groundUnits, path, {path[2], path[1]})`：

- frigate 在边缘创建 → 装载单位 → 飞到 `path[1]`（starport 附近）卸货 → 飞回边缘销毁
- 若购物车同时含 carryall，frigate 到达 280 ticks 后 `Reinforcements.Reinforce` 单独投放 carryall

**卸货后行为**（`OnPassengerExited`）：
- `AttackMove` → 无此属性则 `FindResources`（harvester）→ 无则 `Move`
- 通知：`Media.PlaySpeechNotification(player, "Reinforce")`

### 4.5 Starport 重定向

frigate 飞行期间，若选中的 starport 被摧毁：
- `OnRemovedFromWorld(starport)` → `SelectStarport` 重新选
- 有替代 starport：`frigate.Stop()` + `frigate.Move(新starport + (1,1))` + `frigate.UnloadPassengers()`
- 无替代 starport：`frigate.Stop()` + `frigate.Move(边缘)` 飞离

### 4.6 Frigate 卡住处理

`OnIdle(frigate)` → 若 `HasPassengers` → `frigate.UnloadPassengers()` 强制卸货。

---

## 5. 重置

`ResetStartport(player)`：
- 撤销所有条件（`frigate-not-empty`、`frigate-full`、`shipment-in-progress`）
- 销毁所有 dummy actors
- 销毁 `purchase.starport`
- 清空 `StarportUnits`、`RevokeTokens`、`DummyActors`

frigate 卸货完毕或销毁时自动触发重置。玩家投降时通过 `OnRemovedFromWorld(frigate)` 同样重置。

---

## 6. YAML 依赖

| 文件 | 内容 |
|---|---|
| `rules/starport.yaml` | `^starport_dummy` 基类、13 个 `dummy.xxx`、`purchase.starport`、`^overlay_external_conditions` |
| `rules/structures.yaml` | `starport`：`Production@: Produces: Starport`、`RallyPoint`、`PrimaryBuilding` |
| `starport.lua` | 全部逻辑 |

---

## 7. 常量

- `FrigateDeliveryDelay = DateTime.Seconds(60)` — 下单到交货间隔
- `FrigateCapacity = 6` — 单次运输最大单位数
- `StockConfig[unit]` — `max`（上限）、`charge`（补充间隔，秒）

---

## 8. 条件汇总

| 条件 | 触发 | 效果 |
|---|---|---|
| `stock-depleted-xxx` | 库存归零 | 禁用对应 `dummy.xxx` 建造 |
| `frigate-not-empty` | 购物车从空变非空 | 显示已订购 |
| `frigate-full` | 购物车满 6 件 | 禁止继续下单（`!frigate.full`） |
| `shipment-in-progress` | 确认购买 | 禁止下单 + 新 frigate（`!shipment-in-progress`） |
| `order-N`（1-6） | 同类型第 N 次下单 | dummy 图标叠加显示数量 |

---

## 9. 边界情况

| 情况 | 处理 |
|---|---|
| 玩家投降时 frigate 在途中 | `OnPlayerLost` → `CleanupStockForPlayer`；`OnRemovedFromWorld(frigate)` → `ResetStartport` |
| starport 在交货期间被摧毁 | frigate 重定向到其他 starport；无则飞离地图 |
| frigate 被击落 | `OnRemovedFromWorld(frigate)` → `ResetStartport`，已订单位丢失 |
| carryall 运送中被击落 | `OnIdle`/`OnRemovedFromWorld` 计数，全丢失后超时兜底重置 |
| 重复点击 purchase | `shipment-in-progress` 条件阻止；刚开局延迟初始化时 `InitStockForPlayer` 兜底 |
| 购物车为空点 purchase | `purchase.Destroy()` 静默返回 |
| 库存耗尽时下单 | `HasStock` → false → `dummy.Destroy()` |
| 预置 starport（地图自带） | `InitStarport` 中检测已存在的 starport → 立即 `InitStockForPlayer` |
| frigate 卡住（HasPassengers 但不卸货） | `OnIdle` 强制 `UnloadPassengers` |
| RallyPoint 在 starport footprint 内 | 回退 `sloc + (1,3)` |
| 多 starport | Primary 优先，无则随机 |

---

## 10. 与 Ordos Reinforcements 的关系

Ordos reinforcements 依赖 starport 系统：
- `PlayerHasAnyStarport(player)` → `GetActorsByType("starport")`
- `PlayerQualifies` → `upgrade.starport`（starport 升级后的 prerequisite）
- `OrdosOriginStarports` 血统标记 → `BindStarportHooks` 中的 `OnCapture`/`OnRemovedFromWorld` 依赖 starport actor

starport 系统本身独立运作，不依赖 ordos reinforcements。

---

## 11. 不做什么

- **不** 新增长时间缓存 — 库存即时查询，RallyPoint 每次计算
- **不** 并发运输 — `shipment-in-progress` 锁保证同时只有一班 frigate
- **不** 部分交货 — 所有单位同一 frigate 送达，丢失则全部丢失
- **不** 库存跨 starport 区分 — 一个 player 一个库存池
- **不** 改动 C# — 纯 Lua + YAML

---

## 补充说明

### 生产时间

生产时间公式：`BuildDuration / 25 × BuildTimeSpeedReduction / 100`。

BuildTimeSpeedReduction 按工厂数量递减：
- **Vehicle**（light_factory）：100% / 66% / 50%（继承 base d2k `player.yaml`，Enhanced 未覆盖）
- **Armor**（heavy_factory）：100% / 75% / 50%（Enhanced `world.yaml` 覆盖）
- **Aircraft**（high_tech_factory）：100% / 75% / 50%（Enhanced `world.yaml` 覆盖）

### 从 Purchase 到图标恢复可订购 耗时

| 事件 | 时间点 |
|---|---|
| 按下 Purchase → `shipment-in-progress` 立即 grant → 所有 dummy 图标灰化 | 0 秒 |
| OrderPlaced 语音播放 | 0 秒 |
| T-Minus 5 语音（`AfterDelay(12-15=-3)`，约 0 秒立即触发） | ~0 秒 |
| T-Minus 4 语音（`AfterDelay(24)`） | 24 秒 |
| T-Minus 3 语音（`AfterDelay(36)`） | 36 秒 |
| T-Minus 2 语音（`AfterDelay(48)`） | 48 秒 |
| T-Minus 1 语音（`AfterDelay(60)`）+ `FrigateDeliveryDelay(60s)` 到期 → frigate 在 map edge 生成 | 60 秒 |
| frigate 从 map edge 飞到 starport，开始卸载 | 65-75 秒 |
| 卸载完成，frigate 飞回 edge | 67-80 秒 |
| frigate 退出地图 → `OnRemovedFromWorld` → `ResetStartport` → 图标恢复 | 72-95 秒 |
