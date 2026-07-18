# Support Powers 文本整理

Source: `structures.yaml` (Enhanced11)

> `\n` 在 MiniYaml 中不被解析为换行符。需通过 Fluent 文件实现多行。

---

## Atreides Airstrike

**新 Description**

> 扑翼机从来不是亚崔迪的第一选择。但当它们出现时——蛇形编队，翼尖擦着沙丘——你已经在谈判桌上输掉了最后一轮。

> Ornithopters were never the first choice of House Atreides. But when they appear — snake formation, wingtips skimming the dunes — you already lost the last round at the negotiating table.

| 当前 Name | 当前 Description | 备注 |
|----------|------------------|------|
| Atreides Airstrike | 3 Bomb-armed ornithopters from map edge\nin snake formation. | `SpawnActorPower@atreides_airstrike` |

---

## Ordos Airstrike

**新 Description**

> 叛变者扑翼机从地图边缘升空，散开，各自寻找猎物。它们投下的不是炸弹——是忠诚的迷雾。刚才还在向你开火的那个车组，现在正在向自己的友军开火。

> Deviator Ornithopters lift from the map edge, scatter, and hunt. They don't drop bombs — they drop a fog of allegiance. The crew that was shooting at you moments ago is now shooting at its own.

| 当前 Name | 当前 Description | 备注 |
|----------|------------------|------|
| Ordos Airstrike | 6 Deviator ornithopters from map edge.\nFly to target then engage nearby enemies. | `SpawnActorPower@ordos_airstrike` |

---

## Recruit Fremen

**新 Description**

> 弗瑞曼人不需要军令。他们的脚印还没消失，沙漠就已经替他们传了话。战士和沙地奔袭者从地图边缘的尘暴里走出来。召唤尚未发出，他们已经听见。

> The Fremen don't need orders. Their footprints haven't faded, and the desert has already delivered the message. Warriors and Sand Runners walk out of a dust storm at the map's edge. They heard the summons before it was sent.

| 当前 Name | 当前 Description | 备注 |
|----------|------------------|------|
| Recruit Fremen | 7 Fremen + 2 Sand Runners from map edge | `ProduceActorPower@atreides_reinforcements` |

---

## Death Hand

**新 Description**

> 一枚原子集束弹头从哈肯尼宫殿塔顶升空，在目标上空分裂，落下的地方只剩玻璃。

> An atomic cluster warhead lifts from the Harkonnen Palace rooftop, splits above the target, and where it lands, only glass remains.

| 当前 Name | 当前 Description | 备注 |
|----------|------------------|------|
| Death Hand | Launches an atomic missile at a target location | `NukePower` |

---

## Recruit Saboteur

**新 Description**

> 一颗只需要名字和目标的活体炸弹。它消失在地平线的热浪中，再出现时已站在敌方建筑的门口。

> A walking bomb that needs only a name and a target. It vanishes into the horizon's heat-shimmer, and reappears at the enemy's doorstep.

| 当前 Name | 当前 Description | 备注 |
|----------|------------------|------|
| Recruit Saboteur | Sneaky infantry, permanently cloak\n... | `ProduceActorPower@saboteur` |

---

## Rally Sardaukars

**新 Description**

> 号角响起。萨督卡放弃掩体，站直，开始冲锋。没有人能在正面战斗中阻止他们——六个世纪，无一次例外。

> The horn sounds. Sardaukar abandon cover, stand upright, and begin their charge. No one has stopped them in a stand-up fight. Six centuries. No exceptions.

| 当前 Name | 当前 Description | 备注 |
|----------|------------------|------|
| Rally Sardaukars | Boost sardaukar morale and speed for short period of time | `ProduceActorPower@releasethesardaukars` |

---

## Worm Rider

**新 Description**

> 一名弗瑞曼耐布的生命中只有一次机会向造物主之钩证明自己。他把钩锚钉入沙层。沙胡鲁德应召而来。他骑上巨兽，沙虫的阴影从此属于他的部族。

> A Fremen Naib gets one chance in his lifetime to prove himself to the maker hooks. He anchors them into the sand. Shai-Hulud answers. He mounts the great beast, and the worm's shadow belongs to his tribe from that moment on.

| 当前 Name | 当前 Description | 备注 |
|----------|------------------|------|
| Worm rider | Deploy to ride worm. | `ProduceActorPower@wormrider` |
