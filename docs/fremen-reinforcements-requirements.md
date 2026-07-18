# Fremen Reinforcements（Atreides）— 需求文档

## 概述

Atreides 招募 Fremen 增援。玩家建造 `palace.atreides` 后，右上角出现 Recruit Fremen support power 图标。充能 2:00 后点击，waypoint 在 palace 出口生成，Lua 检测到后从地图边缘沙地 spawn 7 个 fremen + 3 个 sand_runner，向 palace RallyPoint 行军。

Faction 由 `palace.atreides` 的 `Prerequisites`（含 `~conyard.atreides`）天然锁定。

---

## 1. 触发链路

```
玩家点图标
  → ProduceActorPower.Activate()
    → Production.Produce("waypoint.atreides_reinf", type="PalaceQueue")
      → waypoint 在 palace 出口生成
        → scripts.lua Tick() 的 ActorsAddedToWorld 检测到
          → SpawnFremenReinforcements(player)
          → actor.Destroy()
```

| 事项 | 说明 |
|---|---|
| 充能 | `ChargeInterval: 3000`（2:00），`StartFullyCharged: false` |
| 并发保护 | SupportPower 充能间隔（点击后进入充能，2 分钟内不可再点）+ waypoint 检测后立即 Destroy |
| 多 palace | 共享同一 SupportPower instance；全部丢失后重建重新充能 |

---

## 2. Palace 选择与 RallyPoint

**Palace 选择**：Primary（`IsPrimaryBuilding`）优先，无则 `Utils.Random` 随机。

**RallyPoint**：`palace.RallyPoint`，nil 时回退 `palace.Location`。玩家可随时修改。

---

## 3. 边缘 Spawn 点 — 探针可达性验证

委托引擎 `Mobile.Move` 做权威判定：创建探针 → `Move(dest)` → 5 tick 后检查 `IsIdle`（Idle=不可达，非 Idle=可达）。

**流程**：
1. `Map.ClosestMatchingEdgeCell` 枚举全部边缘格 → 筛选 Sand/SpiceSand/Dune → 按距 palace 距离排序 → 截断到最近 50 个
2. 从近到远顺序探测，首个可达即返回
3. RallyPoint 不可达时自动 retry `palace.Location`

**探针**：`probe.reachability`（`rules/vehicles.yaml`），Inherits `raider`，Cloak 0 延迟，Owner=PlayerNeutral，HP 50000。

---

## 4. Spawn

- 7 × `fremen`，间隔 25 ticks/人
- 3 × `sand_runner`，250 ticks 偏移后间隔 10 ticks/辆
- 全部 `Actor.Create` + `unit.Move(dest, closeEnough=3)`
- 通知由 SupportPower 框架的 `ReadyAudio: Reinforce` 处理，Lua 内部不重复播放

---

## 5. 缓存

`FremenEdgeCache = {["X,Y"] = {edge, dest, actualDest}}`，key 为 palace 位置字符串。

- **命中**：`cached.dest == currentDest` → 直接用 `cached.edge`
- **失效**：palace 被摧毁/出售清除缓存；RallyPoint 变更导致 dest 不匹配 → cache miss
- **nil 缓存**：全部不可达时缓存 `{dest = origDest}`，下次走 `ClosestEdgeCell` 兜底，避免反复探测 50 个候选格

---

## 6. 单位

| 单位 | 来源 | 备注 |
|---|---|---|
| `fremen` | `rules/infantry.yaml` | `-Buildable`，`InitialStance: ReturnFire`，HP 回复 |
| `sand_runner` | `rules/vehicles.yaml` | Inherits `trike`，Speed 120，沙地隐形，`-Buildable`，`ReturnFire` |

---

## 7. 文件组织

| 文件 | 内容 |
|---|---|
| `atreides_reinforcements.lua` | 探针、缓存、`SpawnFremenReinforcements`、`DoFremenSpawn` |
| `scripts.lua` | `Tick()` 中检测 `waypoint.atreides_reinf` → 调用 + Destroy |
| `rules/structures.yaml` | `palace.atreides`：`ProduceActorPower@atreides_reinforcements`、RallyPoint、PrimaryBuilding、Production@palace |
| `rules/vehicles.yaml` | `sand_runner`、`probe.reachability` |
| `rules/infantry.yaml` | `fremen` |
| `rules/misc.yaml` | `waypoint.atreides_reinf`（带 `Buildable: Queue: PalaceQueue, Prerequisites: ~disabled`） |
| `rules/world.yaml` | `Scripts:` 加 `atreides_reinforcements.lua` |

---

## 8. 常量

- `FremenProbeCheckDelay = 5`（tick）
- `FremenSpawnCloseEnough = 3`
- `FremenMaxCandidates = 50`
- 充能间隔由 `ProduceActorPower.ChargeInterval: 3000` 控制

---

## 9. 边界情况

| 情况 | 处理 |
|---|---|
| 所有边缘候选格不可达 | nil 缓存 + 回退 `ClosestEdgeCell` |
| RallyPoint 不可达 | 自动 retry palace.Location；成功后缓存 `actualDest` |
| 地图无沙地边缘 | 候选集为空 → 立即 `callback(nil)` → 兜底 |
| palace 探针期间被摧毁/capture | `picked.IsDead` / `picked.Owner ~= player` guard 中止 |
| 探针被意外杀死 | `probe.IsDead` → `callback(false)` → tryNext |
| 全部 palace 丢失后重建 | SupportPower key 移除 → 新建 → `StartFullyCharged: false` 重新充能 |

---

## 10. 不做什么

- **不** 使用 `Reinforcements.Reinforce` — 内部 `nearEnough=2` 硬编码，与探针路径不一致
- **不** Lua 寻路 — 委托引擎 `Mobile.Move`
- **不** 并行探测 — 顺序 tryNext，同时至多 1 探针
- **不** 自动激活 — 玩家手动点击图标
- **不** 两次播放 Reinforce 通知
- **不** 改动 C#
