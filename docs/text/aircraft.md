# Aircraft 文本整理

Source: `aircraft.yaml` (Enhanced11) vs base d2k `fluent/rules.ftl`

> base d2k 原文来自 `G:\prj\OpenRA-Hacking\OpenRA-release-20250330\mods\d2k\fluent\rules.ftl`

---

## carryall (玩家可控)

**新 Description**

> **运输机(手动)** — 铁翼驮兽，腹下悬着战车，双翼切开阿拉基斯滚烫的气流。当它的影子掠过沙丘，地上的人抬头望去，知道自己的命运正被吊在半空。
>   Unarmed
>   Special: 右键抓取载具 · 部署键放下 · Ctrl/Alt 选中
>   Armor: Light — 惧怕一切防空火力

> **Carryall (Manual)** — An iron-winged beast, a war machine slung beneath its belly, twin wings slicing the scorching Arrakis thermals. When its shadow crosses the dunes, the soldiers below look up — and know their fate is suspended in the sky.
>   Unarmed
>   Special: Right-click to pick up vehicles · Deploy to drop · Ctrl/Alt to select
>   Armor: Light — vulnerable to all anti-air fire

| 我的备注 | Tooltip | Description | 备注 |
|---------|---------|-------------|------|
| | 当前: `actor-carryall-reinforce.name` | 当前: controllable carryall \n Use Ctrl or Alt to select \n Use RMB to pick up vehicle \n use Deploy to unload vehicle | Enhanced11 新增玩家可控版 |
| | base: Carryall | base: Large winged, planet-bound ship\nAutomatically lifts harvesters to and from Spice fields.\nLifts vehicles to Repair Pads when ordered to. | |

---

## carryall.reinforce / carryall.support / carryall.transport

**新 Description**

> (AI 控制 — 无需玩家手动操作)

| 我的备注 | Tooltip | Description | 备注 |
|---------|---------|-------------|------|
| - | 当前: `actor-carryall-reinforce.name` | 当前: `actor-carryall-reinforce.description` | AI 运输机 |
| - | base: Carryall | base: Large winged, planet-bound ship\nAutomatically lifts harvesters to and from Spice fields.\nLifts vehicles to Repair Pads when ordered to. | |

---

## ornithopter

**新 Description**

> (无 — base d2k 原版，Enhanced11 未修改)

| 我的备注 | Tooltip | Description | 备注 |
|---------|---------|-------------|------|
| - | 当前: `actor-ornithopter.name` | 当前: `actor-ornithopter.description` | |
| - | base: Ornithopter | base: (ftl 仅 `.name` 和 `.encyclopedia`) | |

---

## ornithopter.sound

**新 Description**

> **音波扑翼机** — 亚崔迪对标准扑翼机的一次"过度投资"：拆掉投弹架，装上一具小型化音波发生器。它掠过敌阵，音波束扫过地面和空中目标——不分敌我，穿透一切。驾驶这种飞行器的飞行员在酒吧里总是单独坐一张桌子。
>   Strong vs Infantry, Light Vehicles, Air
>   Weak vs Heavy Armor
>   Special: 扫射攻击 · 光束穿透友军
>   Armor: Light — 惧怕防空火力

> **Sonic Ornithopter** — An Atreides "over-investment" in the standard Ornithopter airframe: strip the bomb rack, install a miniaturized sonic projector. It screams across the enemy line, sound beam raking both ground and air targets — enemy and ally alike, penetrating everything. Pilots who fly these always sit alone at the bar.
>   Strong vs Infantry, Light Vehicles, Air
>   Weak vs Heavy Armor
>   Special: Strafe attack · Beam hits friend and foe
>   Armor: Light — vulnerable to anti-air fire

| 我的备注 | Tooltip | Description | 备注 |
|---------|---------|-------------|------|
| | 当前: Sonic Ornithopter | 当前: Sonic-armed ornithopter. Strafes ground and air units with sound beam. | Enhanced11 独有 |
| | base: (无此 unit) | base: (无) | |

---

## ornithopter.laser

**新 Description**

> **激光扑翼机** — 奥多斯的回答：当音波不够精确时，他们向伊克斯购买了激光武器改装套件。一道瞬时到达的红色光束，无需弹道预测，无需引导——指向哪里，哪里就燃烧。防空和反地一体。盘旋。瞄准。点燃。重复。
>   Strong vs Infantry, Light Vehicles, Air
>   Weak vs Heavy Armor
>   Special: 即时命中激光 · 可悬停 · 反空反地通用
>   Armor: Light — 惧怕防空火力

> **Laser Ornithopter** — The Ordos answer when sonic wasn't precise enough: they bought a laser retrofit kit from Ix. An instantaneous red beam. No trajectory to predict. No guidance to track. Point. Burn. Repeat. Anti-air and anti-ground. Hover. Aim. Ignite.
>   Strong vs Infantry, Light Vehicles, Air
>   Weak vs Heavy Armor
>   Special: Instant-hit laser · Can hover · Effective vs ground and air
>   Armor: Light — vulnerable to anti-air fire

| 我的备注 | Tooltip | Description | 备注 |
|---------|---------|-------------|------|
| | 当前: Laser Ornithopter | 当前: Laser-armed ornithopter. Instant beam weapon, anti-air and anti-ground. | Enhanced11 独有 |
| | base: (无此 unit) | base: (无) | |

---

## ornithopter.bomber / ornithopter.deviator

**新 Description**

> (AI 专用 — 无需玩家手动操作)

| 我的备注 | Tooltip | Description | 备注 |
|---------|---------|-------------|------|
| - | 当前: Bomber Ornithopter | 当前: (无) | Enhanced11 独有，AI 用 |
| - | 当前: Deviator Ornithopter | 当前: (无) | Enhanced11 独有，AI 用 |

---

## frigate.harkonnen_fortress

**新 Description**

> **哈肯尼空中堡垒** — 如果毁灭者能飞，它就会长成这样。一台在云层高度巡航的巨型悬浮炮艇，左右各一门电击加农炮撕碎地面，背部一座速射炮塔收割空中单位。缓慢——慢得让人会忘记它在移动——但当它滑入你的基地上空时，整个雷达屏幕都会变红。
>   Strong vs Ground Vehicles, Tanks, Air
>   Weak vs Massed anti-air
>   Special: 独立的地面/防空三炮塔系统 · VTOL · 4 发弹药后装填
>   Armor: Light — 大量 HP，惧怕集中防空火力

> **Harkonnen Air Fortress** — If the Devastator could fly, it would look like this. A massive hovering gunship cruising at cloud altitude. Shock cannons on both flanks tear into the ground. A rapid-fire turret on top reaps the sky. Slow — so slow you forget it's moving — but when it slides above your base, the entire radar screen turns red.
>   Strong vs Ground Vehicles, Tanks, Air
>   Weak vs Massed anti-air
>   Special: Three independent turrets (2 ground, 1 AA) · VTOL · 4 ammo, then reload
>   Armor: Light — massive HP pool, vulnerable to concentrated anti-air

| 我的备注 | Tooltip | Description | 备注 |
|---------|---------|-------------|------|
| | 当前: Harkonnen Air Fortress | 当前: Shock cannon + missile battery.\nHeavy Harkonnen air fortress. | Enhanced11 独有 |
| | base: `actor-frigate-name`: Frigate | base: (ftl 仅 `.name`) | |

---

## frigate_choam

**新 Description**

> **CHOAM 运输舰** — 公会特许的星际货运船在沙丘上方现身，投放你在星港订购的货物后立即离场，从不逗留。它不属于你。它只是路过。满载武器，横穿战区，没有一个人朝它开火——公会的中立旗帜是阿拉基斯唯一的普适豁免。生意就是生意。
>   Unarmed — 运载星港采购货物入场，卸货后自动离场
>   Armor: Heavy — 能承受战区火力穿越而不坠

> **CHOAM Frigate** — A Guild-chartered interstellar freighter that materializes above the dunes, drops the cargo you ordered at the Starport, and leaves. Never stays. Never fights. It isn't yours. It just passes through — fully loaded with weaponry, crossing the combat zone — and no one shoots at it — the Guild's neutral banner is the only universal immunity on Arrakis. Business is business.
>   Unarmed — Delivers Starport purchases, departs after unloading
>   Armor: Heavy — tanks crossfire to deliver

| 我的备注 | Tooltip | Description | 备注 |
|---------|---------|-------------|------|
| | 当前: `actor-frigate-name` | 当前: (无) | CHOAM 送货 |
| | base: Frigate | base: (ftl 仅 `.name`) | |
