# Deviator Strike Support Power

## 需求

### 概述

Ordos 专属空中支援技能。从地图边缘召唤 6 架 Deviator Ornithopter，飞向目标区域后自动索敌攻击，计时结束或弹药用尽后自爆。

### 详细需求

- **阵营限定**：仅 Ordos（`RequiresCondition: ordos`）
- **前置科技**：`~techlevel.superweapons` + `upgrade.hightech`
- **冷却时间**：9000 ticks（6 分钟）
- **飞机数量**：6 架
- **进场姿态**：地图最近边缘 → 目标点，`HoldFire` 禁火
- **作战姿态**：距目标 30 格内切换 `Defend`，自动攻击
- **自爆条件**：
  - 进入作战姿态后 37 秒（925 ticks）自爆
  - 弹药耗尽（6 发 clusterDeviatorMissile）后 13 ticks 自爆
- **死亡效果**：C4 二次爆炸（`ornithopter.c4_husk`）
- **不可控**：不可选择，不接受任何玩家/AI 指令
- **清理**：全部阵亡后销毁 waypoint

### 武器

- `clusterDeviatorMissile`：继承 `DeviatorMissile`，`ReloadDelay: 20`，含 `ChangeOwner` 弹头（临时叛变 405 ticks）
- 对地/水/空有效，不对建筑

---

## 实现

### 架构

```
玩家点击地图
    → SpawnActorPower@DeviatorStrike (structures.yaml)
        → 生成 waypoint.deviator_strike
            → Lua OnActorAdded 钩子
                → CallDeviatorStrike(waypoint)
                    → 从边缘 spawn 6 架 ornithopter.deviator
                    → HoldFire 飞向目标
                    → CheckEngage 轮询距离
                        → ≤30 格 → Defend + 启动 37s 自杀计时器
```

### 涉及文件

| 文件 | 角色 |
|------|------|
| `rules/structures.yaml:1432` | `SpawnActorPower@DeviatorStrike` 支持技能按钮 |
| `rules/misc.yaml:115` | `waypoint.deviator_strike` 航点载体 |
| `scripts_new.lua:275-1125` | `OnActorAdded` 钩子 + `CallDeviatorStrike` + `CheckEngage` |
| `rules/aircraft.yaml:290` | `ornithopter.deviator` 飞机定义 |
| `weapons/weapons.yaml:505` | `DeviatorMissile` 基准武器 |
| `weapons/weapons.yaml:687` | `clusterDeviatorMissile` 速射变体 |
| `rules/husks.yaml:142` | `ornithopter.c4_husk` C4 爆炸残骸 |
| `rules/defaults.yaml:38` | `^AutoTargetPriorityATVI` 攻击优先级模板 |

### 关键 Lua 逻辑

```
CallDeviatorStrike(dummy)
    ├── Beacon 350 ticks @ 目标位置
    ├── baseCell = Map.ClosestEdgeCell(dummy.Location)
    ├── for i = 1..6:
    │   ├── delay = i×18 + random(0,7)
    │   ├── offset = random(±1536, ±1537) 子格
    │   └── Actor.Create("ornithopter.deviator", ...)
    │       ├── Stance = "HoldFire"
    │       ├── unit.Move(dummy.Location)
    │       └── CheckEngage(unit, targetWPos)
    └── Trigger.AfterDelay(150):
        └── OnAllRemovedFromWorld(alive) → dummy.Destroy()

CheckEngage(unit, targetWPos)
    ├── if dead → return
    ├── if HoldFire && dist² ≤ (30×1024)²:
    │   ├── unit.Stance = "Defend"
    │   └── unit.GrantCondition("engage-timer")
    └── else → AfterDelay(20) → recurse
```

### 飞机关键 Trait

```yaml
ornithopter.deviator:
    Inherits: ornithopter
    Inherits@TargetPriority: ^AutoTargetPriorityATVI

    # 不可控
    -Selectable:
    Interactable:
    RejectsOrders:

    # 武器
    Armament@primary:
        Weapon: clusterDeviatorMissile
        ForceTargetRelationships: Enemy, Ally, Neutral
        PauseOnCondition: !ammo
    AmmoPool: { Ammo: 6, AmmoCondition: ammo }

    # 两种自爆
    KillsSelf@outOfAmmo: { Delay: 13,  RequiresCondition: out-of-ammo }
    KillsSelf@engageTimer: { Delay: 925, RequiresCondition: engage-timer }

    # 死亡
    SpawnActorOnDeath@c4: { Actor: ornithopter.c4_husk }
```

### 自爆时序

```
                               弹药=0 ─→ out-of-ammo ─→ KillsSelf (13t) ─┐
                              │                                              ▼
Spawn ─→ HoldFire ─→ Defend ─┤                                         C4 爆炸 ─→ 销毁 waypoint
                              │                                              ▲
                              └── engage-timer ─→ KillsSelf (925t) ────────┘
```
