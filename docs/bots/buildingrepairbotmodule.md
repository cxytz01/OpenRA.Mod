# BuildingRepairBotModule

Source: `OpenRA.Mods.Common\Traits\BotModules\BuildingRepairBotModule.cs`

## 继承

`ConditionalTraitInfo`

## 配置（三个 bot 共用）

| 配置项 | 类型 | 默认值 | EN 当前值 |
|---|---|---|---|
| `RequiresCondition` | BooleanExpression | `null` | `enable-omnius-ai \|\| enable-vidious-ai \|\| enable-gladius-ai` |

（该模块无其他配置字段，仅靠 `RequiresCondition` 控制开关。AI 基地受攻击时自动修理建筑。）
