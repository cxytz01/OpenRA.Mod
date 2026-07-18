# McvManagerBotModule

Source: `OpenRA.Mods.Common\Traits\BotModules\McvManagerBotModule.cs`

## 继承

`ConditionalTraitInfo`

## Omnius / Gladius 共用

| 配置项 | 说明 | 类型 | 默认值 | 当前值 | 自定义值 |
|---|---|---|---|---|---|
| `RequiresCondition` | 启用条件 | BooleanExpression | `null` | `enable-omnius-ai \|\| enable-gladius-ai` | |
| `McvTypes` | MCV 类型 | HashSet\<string\> | `{}` | `mcv, mcv.starport, dummy.mcv` | `mcv,dummy.mcv` |
| `ConstructionYardTypes` | 建造场类型 | HashSet\<string\> | `{}` | `construction_yard` | |
| `McvFactoryTypes` | MCV 工厂类型 | HashSet\<string\> | `{}` | `heavy_factory, starport` | |
| `MinimumConstructionYardCount` | 最少建造场数 | int | `1` | `3` | 4 |
| `ScanForNewMcvInterval` | MCV 扫描间隔(tick) | int | `20` | `100` | |
| `MinBaseRadius` | 最小部署距离(格) | int | `2` | `20` | |
| `MaxBaseRadius` | 最大部署距离(格) | int | `20` | (默认) | |
| `RestrictMCVDeploymentFallbackToBase` | 限制部署回基地范围 | bool | `true` | `false` | |

## Vidious 独立

| 配置项 | 说明 | 类型 | 默认值 | 当前值 | 自定义值 |
|---|---|---|---|---|---|
| `RequiresCondition` | 启用条件 | BooleanExpression | `null` | `enable-vidious-ai` | |
| `McvTypes` | MCV 类型 | HashSet\<string\> | `{}` | `mcv, dummy.mcv, mcv.starport` | `mcv,dummy.mcv` |
| `ConstructionYardTypes` | 建造场类型 | HashSet\<string\> | `{}` | `construction_yard` | |
| `McvFactoryTypes` | MCV 工厂类型 | HashSet\<string\> | `{}` | `heavy_factory, starport` | |
| `MinimumConstructionYardCount` | 最少建造场数 | int | `1` | `4` | |
| `ScanForNewMcvInterval` | MCV 扫描间隔(tick) | int | `20` | `150` | |
| `MinBaseRadius` | 最小部署距离(格) | int | `2` | `20` | |
| `MaxBaseRadius` | 最大部署距离(格) | int | `20` | `50` | |
| `RestrictMCVDeploymentFallbackToBase` | 限制部署回基地范围 | bool | `true` | `True` | |
