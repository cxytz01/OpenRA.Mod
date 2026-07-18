# SquadManagerBotModule

Source: `OpenRA.Mods.Common\Traits\BotModules\SquadManagerBotModule.cs`

## 继承

`ConditionalTraitInfo`

## 基础配置

| 配置项 | 说明 | 类型 | 默认值 | Gladius | Omnius | Vidious |
|---|---|---|---|---|---|---|
| `RequiresCondition` | 启用条件 | BooleanExpression | `null` | `enable-gladius-ai` | `enable-omnius-ai` | `enable-vidious-ai` |
| `SquadSize` | 攻击前最少集结单位数 | int | 8 | 25 | 15 | 7 |
| `SquadSizeRandomBonus` | 建攻击队时在 SquadSize 基础上随机追加 0~N 个单位 | int | 30 | 25 | 15 | 7 |
| `AssignRolesInterval` | 分配角色检查间隔(tick)。每 N tick 扫描一次新单位并编入对应编队 | int | 50 | - | - | - |
| `RushInterval` | Rush 攻击尝试间隔(tick)。向敌方建造场方向发动闪电突袭的频率 | int | 600 | 1500 | 3375 | 3024 |
| `AttackForceInterval` | 编队状态更新间隔(tick)。每 N tick 对所有小队刷新一次目标/移动/攻击决策 | int | 75 | (默认) | 80 | 90 |
| `MinimumAttackForceDelay` | 两次创建攻击编队之间的最小冷却(tick) | int | 0 | 100 | 100 | 100 |
| `RushAttackScanRadius` | Rush 时扫描敌方建造场附近的敌军半径(格) | int | 15 | (默认) | (默认) | (默认) |
| `ProtectUnitScanRadius` | 搜索可用保护单位的基地扫描半径(格) | int | 15 | 25 | 25 | 25 |
| `MaxBaseRadius` | 从基地中心计算的最大编队活动距离(格) | int | 20 | 40 | 100 | 100 |
| `IdleScanRadius` | 空闲状态下编队搜索敌人的半径(格) | int | 10 | 20 | 45 | 30 |
| `DangerScanRadius` | 编队判断是否撤退时扫描危险的半径(格) | int | 10 | 20 | 20 | 20 |
| `AttackScanRadius` | 攻击移动中扫描敌人的半径(格)。发现敌人后切换到直接攻击状态 | int | 12 | 13 | 15 | 17 |
| `ProtectionScanRadius` | 保护编队扫描威胁的半径(格) | int | 8 | 13 | 13 | 13 |

## 单位类型 (HashSet\<string\>)

| 配置项 | 说明 | 类型 | Gladius | Omnius | Vidious |
|---|---|---|---|---|---|
| `AirUnitsTypes` | 标记为空中单位的 actor 类型。不参与地面攻击，单独编入空军编队 | HashSet\<string\> | - | - | - |
| `ExcludeFromSquadsTypes` | 排除在攻击编队之外的 actor 类型。通常包括工程师、矿车、MCV、运输机等非战斗单位 | HashSet\<string\> | carryall.reinforce, carryall, carryall.support, carryall.transport, ornithopter.bomber, ornithopter.deviator, frigate_choam, engineer, saboteur, probe.reachability, mcv, harvester, dummy.generic, dummy.sardaukar_rally, waypoint.ordos_airstrike, waypoint.atreides_airstrike, waypoint.atreides_reinf, dummy.kill_self, dummyShrapnelThrower, dummyShrapnelThrower_carryall, dummy.gas_leak | 同 | 同 |
| `ConstructionYardTypes` | 视为基地建造场的 actor 类型。用于 Rush 时定位敌方基地 | HashSet\<string\> | `construction_yard` | `construction_yard` | `construction_yard` |
| `ProtectionTypes` | 受保护优先级最高的己方 actor 类型。这些被攻击时会触发保护编队 | HashSet\<string\> | construction_yard, mcv, medium_gun_turret, large_gun_turret, refinery, refinery_inverted, barracks, light_factory, heavy_factory, high_tech_factory, starport, research_centre, palace.atreides, palace.harkonnen, palace.ordos, palace.corrino, fremen_sietch, harvester, wind_trap, outpost, repair_pad, engineer | 同 | 同 |
| `NavalUnitsTypes` | 标记为海军单位的 actor 类型。单独编入海军编队 | HashSet\<string\> | (默认) | (默认) | (默认) |
| `NavalProductionTypes` | 敌方海军生产建筑类型。海军编队扫描目标时以这些建筑为中心 | HashSet\<string\> | (默认) | (默认) | (默认) |

## 目标 & 飞机

| 配置项 | 说明 | 类型 | 默认值 | Gladius | Omnius | Vidious |
|---|---|---|---|---|---|---|
| `AircraftTargetType` | 用于识别空中目标的 TargetType 位集 | BitSet\<TargetableType\> | `Air` | (默认) | (默认) | (默认) |
| `IgnoredEnemyTargetTypes` | 永远不攻击的敌方目标类型。用于排除悬崖、蠕虫、Bib 等不可攻击实体 | BitSet\<TargetableType\> | `default` | `Creep, Cliff, Air, AirSupport, CapturedUnit` | 同 | 同 |
