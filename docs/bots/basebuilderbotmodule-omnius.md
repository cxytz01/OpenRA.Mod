# Omnius — BaseBuilderBotModule

## 基础配置

| 配置项 | 说明 | 默认值 | 当前值 | 自定义值 |
|--------|------|--------|--------|------------------------------------------|
| `RequiresCondition` | 启用条件 | `null` | `enable-omnius-ai` | |
| `BuildingQueues` | 建筑生产队列 | `Building` | `Building, Upgrade` | |
| `DefenseQueues` | 防御生产队列 | `Defense` | (默认) | |
| `ConstructionYardTypes` | 建造场类型 | `{}` | `construction_yard` | |
| `VehiclesFactoryTypes` | 载具工厂类型 | `{}` | `light_factory, heavy_factory, starport` | |
| `RefineryTypes` | 精炼厂类型 | `{}` | `refinery, refinery_inverted` | |
| `PowerTypes` | 电厂类型 | `{}` | `wind_trap` | |
| `BarracksTypes` | 兵营类型 | `{}` | `light_factory` | |
| `ProductionTypes` | 生产建筑类型 | `{}` | `barracks, light_factory, heavy_factory, starport, high_tech_factory` | |
| `NavalProductionTypes` | 海军工厂类型 | `{}` | (未设置) | |
| `SiloTypes` | 仓库类型 | `{}` | `silo` | |
| `DefenseTypes` | 防御塔类型 | `{}` | `medium_gun_turret, large_gun_turret` | |
| `WaterTerrainTypes` | 水域地形 | `Water` | (默认) | |

## 基地范围 & 电力

| 配置项 | 说明 | 默认值 | 当前值 | 自定义值 |
|--------|------|--------|--------|------------------------------------------|
| `MinBaseRadius` | 最小建造距离(格) | `2` | (默认) | |
| `MaxBaseRadius` | 最大扩张半径(格) | `20` | `35` | |
| `MinimumExcessPower` | 最低冗余电力 | `0` | `80` | |
| `MaximumExcessPower` | 冗余电力上限 | `0` | `600` | |
| `ExcessPowerIncrement` | 每门槛增加电力 | `0` | `10` | |
| `ExcessPowerIncreaseThreshold` | 增电力门槛(建筑数) | `1` | `4` | |
| `InititalMinimumRefineryCount` | 兵营前最少精炼厂 | `1` | `2` | |
| `AdditionalMinimumRefineryCount` | 兵营后额外精炼厂 | `1` | `3` | |

## 建造时机

| 配置项 | 说明 | 默认值 | 当前值 | 自定义值 |
|--------|------|--------|--------|------------------------------------------|
| `StructureProductionInactiveDelay` | 空闲检查间隔(tick) | `125` | `50` | |
| `StructureProductionActiveDelay` | 活跃检查间隔(tick) | `25` | `25` | |
| `StructureProductionRandomBonusDelay` | 随机附加值(tick) | `10` | (默认) | |
| `StructureProductionResumeDelay` | 失败重试延时(tick) | `1500` | (默认) | |
| `MaximumFailedPlacementAttempts` | 最大失败次数 | `3` | `4` | |
| `MaxResourceCellsToCheck` | 炼厂选址矿点检查数 | `3` | `15` | |
| `CheckForNewBasesDelay` | 扫码新基地间隔(tick) | `1500` | `1500` | |
| `MinimumDefenseRadius` | 防御最小距离(格) | `5` | `5` | |
| `MaximumDefenseRadius` | 防御最大距离(格) | `20` | `30` | |
| `NewProductionCashThreshold` | 余钱加建工厂阈值 | `5000` | `1500` | |
| `ProductionMinCashRequirement` | 最低建造现金 | `500` | `700` | |
| `RallyPointScanRadius` | 集结点扫描半径(格) | `8` | `15` | |
| `CheckForWaterRadius` | 水域扫描半径(格) | `8` | (默认) | |
| `AssignRallyPointsInterval` | 集结点重分配间隔(tick) | `100` | `500` | |

## BuildingLimits

| 建筑 | 说明 | 当前值 | 自定义值 |
|------|------|--------|------------------------------------------|
| `refinery` | 精炼厂 | - | |
| `refinery_inverted` | 精炼厂(反向) | - | |
| `wind_trap` | 风电厂 | - | |
| `barracks` | 兵营 | 4 | |
| `light_factory` | 轻工厂 | 4 | |
| `outpost` | 前哨站 | 2 | |
| `heavy_factory` | 重工厂 | 3 | |
| `high_tech_factory` | 高科技工厂 | 3 | |
| `repair_pad` | 修理平台 | 2 | |
| `research_centre` | 研究中心 | 2 | |
| `starport` | 星港 | 2 | |
| `palace.atreides` | Atreides宫殿 | 2 | |
| `palace.harkonnen` | Harkonnen宫殿 | 2 | |
| `palace.ordos` | Ordos宫殿 | 2 | |
| `palace.corrino` | Corrino宫殿 | 2 | |
| `fremen_sietch` | 弗瑞曼穴地 | 2 | |
| `silo` | 仓库 | - | |
| `medium_gun_turret` | 中型炮塔 | - | |
| `large_gun_turret` | 火箭炮塔 | - | |
| `upgrade.conyard` | 建造场升级 | 1 | |
| `upgrade.barracks` | 兵营升级 | 1 | |
| `upgrade.light` | 轻工厂升级 | 1 | |
| `upgrade.heavy` | 重工厂升级 | 1 | |
| `upgrade.starport` | 星港升级 | 1 | |
| `upgrade.hightech` | 高科技升级 | 1 | |

## BuildingFractions

| 建筑 | 说明 | 当前值 | 自定义值 |
|------|------|--------|------------------------------------------|
| `refinery` | 精炼厂 | 15 | |
| `refinery_inverted` | 精炼厂(反向) | 9 | |
| `wind_trap` | 风电厂 | - | |
| `barracks` | 兵营 | 1 | |
| `light_factory` | 轻工厂 | 5 | |
| `outpost` | 前哨站 | 3 | |
| `heavy_factory` | 重工厂 | 2 | |
| `high_tech_factory` | 高科技工厂 | 4 | |
| `repair_pad` | 修理平台 | 3 | |
| `research_centre` | 研究中心 | 1 | |
| `starport` | 星港 | 4 | |
| `palace.atreides` | Atreides宫殿 | 1 | |
| `palace.harkonnen` | Harkonnen宫殿 | 1 | |
| `palace.ordos` | Ordos宫殿 | 1 | |
| `palace.corrino` | Corrino宫殿 | 1 | |
| `fremen_sietch` | 弗瑞曼穴地 | 1 | |
| `silo` | 仓库 | - | |
| `medium_gun_turret` | 中型炮塔 | 8 | |
| `large_gun_turret` | 火箭炮塔 | 6 | |
| `upgrade.conyard` | 建造场升级 | 1 | |
| `upgrade.barracks` | 兵营升级 | 1 | |
| `upgrade.light` | 轻工厂升级 | 1 | |
| `upgrade.heavy` | 重工厂升级 | 1 | |
| `upgrade.starport` | 星港升级 | 1 | |
| `upgrade.hightech` | 高科技升级 | 1 | |

## BuildingDelays

| 建筑 | 说明 | 当前值 | 自定义值 |
|------|------|--------|------------------------------------------|
| `refinery` | 精炼厂 | - | |
| `refinery_inverted` | 精炼厂(反向) | - | |
| `wind_trap` | 风电厂 | - | |
| `barracks` | 兵营 | - | |
| `light_factory` | 轻工厂 | - | |
| `outpost` | 前哨站 | - | |
| `heavy_factory` | 重工厂 | - | |
| `high_tech_factory` | 高科技工厂 | - | |
| `repair_pad` | 修理平台 | - | |
| `research_centre` | 研究中心 | - | |
| `starport` | 星港 | - | |
| `palace.atreides` | Atreides宫殿 | - | |
| `palace.harkonnen` | Harkonnen宫殿 | - | |
| `palace.ordos` | Ordos宫殿 | - | |
| `palace.corrino` | Corrino宫殿 | - | |
| `fremen_sietch` | 弗瑞曼穴地 | - | |
| `silo` | 仓库 | - | |
| `medium_gun_turret` | 中型炮塔 | 8000 | |
| `large_gun_turret` | 火箭炮塔 | - | |
| `upgrade.conyard` | 建造场升级 | 20000 | |
| `upgrade.barracks` | 兵营升级 | 3822 | |
| `upgrade.light` | 轻工厂升级 | - | |
| `upgrade.heavy` | 重工厂升级 | 8858 | |
| `upgrade.starport` | 星港升级 | - | |
| `upgrade.hightech` | 高科技升级 | - | |
