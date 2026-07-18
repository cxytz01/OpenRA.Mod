# CaptureManagerBotModule

Source: `OpenRA.Mods.Common\Traits\BotModules\CaptureManagerBotModule.cs`

## 继承

`ConditionalTraitInfo`

## 配置（三个 bot 共用）

| 配置项 | 类型 | 默认值 | EN 当前值 |
|---|---|---|---|
| `RequiresCondition` | BooleanExpression | `null` | `enable-omnius-ai \|\| enable-vidious-ai \|\| enable-gladius-ai` |
| `CapturingActorTypes` | HashSet\<string\> | `{}` | `engineer` |
| `CapturableActorTypes` | HashSet\<string\> | `{}` | (默认, 目标所有 actor) |
| `MinimumCaptureDelay` | int | `375` | `200` |
| `MaximumCaptureTargetOptions` | int | `10` | (默认) |
| `CheckCaptureTargetsForVisibility` | bool | `true` | `false` |
| `CapturableRelationships` | PlayerRelationship | `Enemy \| Neutral` | (默认) |
