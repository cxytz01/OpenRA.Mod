# HarvesterBotModule

Source: `OpenRA.Mods.Common\Traits\BotModules\HarvesterBotModule.cs`

## 继承

`ConditionalTraitInfo`, `NotBefore<IResourceLayerInfo>`

## 配置（三个 bot 共用）

| 配置项 | 类型 | 默认值 | EN 当前值 |
|---|---|---|---|
| `RequiresCondition` | BooleanExpression | `null` | `enable-omnius-ai \|\| enable-vidious-ai \|\| enable-gladius-ai` |
| `HarvesterTypes` | HashSet\<string\> | `{}` | `harvester` |
| `RefineryTypes` | HashSet\<string\> | `{}` | `refinery, refinery_inverted` |
| `ScanForIdleHarvestersInterval` | int | `50` | (默认) |
| `ScanIntervalMultiplerWhenNoResources` | int | `5` | (默认) |
| `HarvesterEnemyAvoidanceRadius` | WDist | `10c0` | `15c0` |
| `HarvesterEnemyAvoidanceCostMultipler` | int | `20` | (默认) |
