# SupportPowerBotModule

Source: `OpenRA.Mods.Common\Traits\BotModules\SupportPowerBotModule.cs`

## 继承

`ConditionalTraitInfo`, `Requires<SupportPowerManagerInfo>`

## 自有配置

| 配置项 | 类型 | 默认值 | EN 当前值 |
|---|---|---|---|
| `RequiresCondition` | BooleanExpression | `null` | `enable-omnius-ai \|\| enable-vidious-ai \|\| enable-gladius-ai` |
| `Decisions` | List\<SupportPowerDecision\> | `[]` | 见下表 |

## Decision 字段

每个 Decision 代表一个支援技能的使用策略。

| 字段 | 类型 | 默认值 | 说明 |
|---|---|---|---|
| `OrderName` | string | `"AirstrikePowerInfoOrder"` | 匹配 `SpawnActorPower.OrderName` |
| `MinimumAttractiveness` | int | `1` | 最低触发分值 |
| `CoarseScanRadius` | int | `20` | 粗扫描半径（格） |
| `FineScanRadius` | int | `2` | 精扫描半径（格） |
| `MinimumScanTimeInterval` | int | `250` | 失败后最小重试间隔（tick） |
| `MaximumScanTimeInterval` | int | `262` | 失败后最大重试间隔（tick） |
| `Considerations` | List\<Consideration\> | `[]` | 评估条件列表 |

## Consideration 字段

| 字段 | 类型 | 默认值 | 可选值 |
|---|---|---|---|
| `Against` | PlayerRelationship | `Enemy` | `Ally`, `Neutral`, `Enemy` |
| `Types` | BitSet\<TargetableType\> | `Air, Ground, Water` | 任意组合 |
| `Attractiveness` | int | `100` | 加权系数 |
| `TargetMetric` | DecisionMetric | `None` | `Value`, `Health`, `None` |
| `CheckRadius` | WDist | `5c0` | 扫描半径 |

## 当前 Decisions

### AtreidesAirstrike (atreides_airstrike)

| Consideration | 对谁 | 类型 | 系数 | Metric | 半径 | 门槛 |
|---|---|---|---|---|---|---|
| `@1` | Enemy | Defense | 7 | Value | 6c0 | |
| `@2` | Enemy | Vehicle, Tank | 4 | Value | 5c0 | |
| `@3` | Enemy | Structure, Defense | 2 | Value | 8c0 | |
| `@4` | Ally | Ground | -10 | Value | 6c0 | |
| **总体** | | | | | | **5000** |

### OrdosAirstrike (ordos_airstrike)

| Consideration | 对谁 | 类型 | 系数 | Metric | 半径 | 门槛 |
|---|---|---|---|---|---|---|
| `@1` | Enemy | Vehicle, Tank, Air | 5 | Value | 10c0 | |
| `@2` | Enemy | Structure | 1 | Value | 10c0 | |
| `@3` | Enemy | Defense | -10 | Value | 10c0 | |
| `@4` | Ally | Ground | -10 | Value | 10c0 | |
| **总体** | | | | | | **7000** |

### NukePower (Death Hand)

| Consideration | 对谁 | 类型 | 系数 | Metric | 半径 | 门槛 |
|---|---|---|---|---|---|---|
| `@1` | Enemy | Structure, Defense | 8 | Value | 5c0 | |
| `@2` | Enemy | Infantry, Vehicle, Tank, Defense | 5 | Value | 5c0 | |
| `@3` | Ally | Ground | -10 | Value | 5c0 | |
| **总体** | | | | | | **5500** |

### Fremen (ProduceActorPower.AtreidesReinforcements)

| Consideration | 对谁 | 类型 | 系数 | Metric | 半径 | 门槛 |
|---|---|---|---|---|---|---|
| `@1` | Ally | Structure | 1 | (None) | (默认5c0) | |
| **总体** | | | | | | **1** |

### Saboteur (ProduceActorPower.SaboteurOrdos)

| Consideration | 对谁 | 类型 | 系数 | Metric | 半径 | 门槛 |
|---|---|---|---|---|---|---|
| `@1` | Ally | Structure | 1 | (None) | (默认5c0) | |
| **总体** | | | | | | **1** |

### RallySardaukar (Orderproduction.sardaukar)

| Consideration | 对谁 | 类型 | 系数 | Metric | 半径 | 门槛 |
|---|---|---|---|---|---|---|
| `@1` | Ally | Structure | 1 | (None) | (默认5c0) | |
| **总体** | | | | | | **1** |

### WormRider (SpawnActorPowerInfoOrder.wormride)

| Consideration | 对谁 | 类型 | 系数 | Metric | 半径 | 门槛 |
|---|---|---|---|---|---|---|
| `@1` | Ally | Structure | 1 | (None) | (默认5c0) | |
| **总体** | | | | | | **1** |
