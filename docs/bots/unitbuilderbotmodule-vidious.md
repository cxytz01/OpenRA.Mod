# UnitBuilderBotModule — Vidious

Source: `OpenRA.Mods.Common\Traits\BotModules\UnitBuilderBotModule.cs`

## 基础配置

| 配置项 | 说明 | 默认值 | 当前值 | 自定义值 |
|--------|------|--------|--------|------------------------------------------|
| `RequiresCondition` | 启用条件 | `null` | `enable-vidious-ai` | |
| `IdleBaseUnitsMaximum` | 空闲兵上限 | `-1` | `-1` | |
| `UnitQueues` | 生产队列 | Vehicle,Infantry,Plane,Ship,Aircraft | Infantry,Vehicle,Armor,Starport,Aircraft | |
| `ProductionMinCashRequirement` | 最低现金 | `500` | `1100` | |

## UnitsToBuild

| 单位 | 说明 | 当前值 | 自定义值 |
|------|------|--------|------------------------------------------|
| `thumper` | 沙锤 | 1 | |
| `light_inf` | 轻步兵 | 25 | |
| `trooper` | 重步兵 | 15 | |
| `engineer` | 工程师 | 1 | |
| `grenadier` | 掷弹兵 | 3 | |
| `sardaukar` | 帝国卫队 | 15 | |
| `trike` | 三轮 | 4 | |
| `dummy.trike` | 三轮(港) | 1 | |
| `raider` | 突袭车 | 4 | |
| `dummy.raider` | 突袭车(港) | 1 | |
| `stealth_raider` | 隐形突袭 | 2 | |
| `quad` | 四轮 | 6 | |
| `dummy.quad` | 四轮(港) | 1 | |
| `dummy.heavy_quad` | 重四轮(港) | 1 | |
| `dustrider` | 沙尘运输 | 15 | |
| `dummy.dustrider` | 沙尘运输(港) | 1 | |
| `mcv` | MCV | 1 | |
| `dummy.mcv` | MCV(港) | 1 | |
| `harvester` | 采矿车 | 25 | |
| `dummy.harvester` | 采矿车(港) | 1 | |
| `siege_tank` | 攻城坦克 | 6 | |
| `dummy.siege_tank` | 攻城坦克(港) | 1 | |
| `missile_tank` | 导弹坦克 | 30 | |
| `dummy.missile_tank` | 导弹坦克(港) | 3 | |
| `deviator` | 叛变者 | 10 | |
| `sonic_tank` | 音波坦克 | 17 | |
| `devastator` | 毁灭者 | 50 | |
| `combat_tank_a` | A坦 | 25 | |
| `dummy.combat_tank_a` | A坦(港) | 1 | |
| `combat_tank_h` | H坦 | 7 | |
| `dummy.combat_tank_h` | H坦(港) | 1 | |
| `combat_tank_o` | O坦 | 37 | |
| `dummy.combat_tank_o` | O坦(港) | 1 | |
| `carryall` | 运输机 | 5 | |
| `dummy.carryall` | 运输机(港) | 1 | |
| `ornithopter.sound` | 音波鸟 | 3 | |
| `ornithopter.laser` | 激光鸟 | 3 | |
| `frigate.harkonnen_fortress` | 空中堡垒 | 1 | |
| `purchase.starport` | 星港采购 | 1 | |

## UnitLimits

| 单位 | 说明 | 当前值 | 自定义值 |
|------|------|--------|------------------------------------------|
| `engineer` | 工程师 | 2 | |
| `carryall` | 运输机 | 25 | |
| `harvester` | 采矿车 | - | |
| `mcv` | MCV | 1 | |

## UnitDelays (tick)

| 单位 | 说明 | 当前值 | 自定义值 |
|------|------|--------|------------------------------------------|
| `engineer` | 工程师 | 20000 | |
