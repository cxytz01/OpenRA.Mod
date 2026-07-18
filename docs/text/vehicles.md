# Vehicles 文本整理

Source: `vehicles.yaml` (Enhanced11) vs base d2k `fluent/rules.ftl`

> base d2k 原文来自 `G:\prj\OpenRA-Hacking\OpenRA-release-20250330\mods\d2k\fluent\rules.ftl`

---

## trike

**新 Description**

> **三轮摩托** — 阿拉基斯战场上的轻骑兵。三只宽大的越野轮胎、一挺重机枪、一块薄得被打穿时你甚至不会注意到的装甲板。它跑得飞快，转角漂移扬起香料尘埃，是侦察和掠袭的不二之选。但别让它撞上任何比它大的东西。
>   Strong vs Infantry
>   Weak vs Tanks, Rockets
>   Armor: Wood — 惧怕导弹、火炮、音波

> **Trike** — The light cavalry of the Arrakis battlefield. Three oversized tires, a heavy machine gun, and an armor plate so thin you won't notice when it gets punched through. Fast enough to drift through spice-dust corners, perfect for scouting and hit-and-run raids. Just don't let it meet anything bigger than itself.
>   Strong vs Infantry
>   Weak vs Tanks, Rockets
>   Armor: Wood — vulnerable to missiles, cannons, and sonic weapons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-trike.name` | 当前: `actor-trike.description` | |
| base: Trike | base: Fast scout.\n  Strong vs Infantry\n  Weak vs Tanks | |

---

## raider

**新 Description**

> **突袭三轮** — 奥多斯家族对标准三轮的"商业升级"。双联装 20mm 机炮、增强型引擎、以及仅在辛格玛-德拉科尼斯 IV 星云间才能买到的加速调校。没有装甲——是的，完全没有——但当你快到子弹追不上时你也不怎么需要。引擎音浪本身就是一种心理战。
>   Strong vs Infantry, Light Vehicles
>   Weak vs Tanks, Rockets
>   Armor: None — 极端惧怕一切火力

> **Raider Trike** — House Ordos "business upgrade" to the standard Trike. Twin 20mm cannons. A tuned engine only available through Sigma Draconis IV middlemen. Zero armor — yes, literally none — but when you're faster than the bullets, you don't need it as much. The engine howl is a psychological weapon all by itself.
>   Strong vs Infantry, Light Vehicles
>   Weak vs Tanks, Rockets
>   Armor: None — extremely vulnerable to all fire

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-raider.name` | 当前: Fast scout \n Strong vs Infantry\n  Weak vs Tanks, Rockets \n Armor: none | 加了"Armor: none"和"Rockets"弱点 |
| base: Raider Trike | base: Improved Scout.\n  Strong vs Infantry and Light Vehicles\n  Weak vs Tanks | |

---

## stealth_raider

**新 Description**

> **隐形突袭三轮** — 伊克斯科技的禁忌果实。一台安装了动态迷彩隐形网的三轮突袭车，在沙漠热浪中只剩一缕扭曲的波纹。步兵靠近到触手可及的距离才能识别，哨戒炮在三个车身的距离能捕捉到轮廓，只有前线基地的远程雷达阵列能在安全距离外给出预警。当它消失在你后视镜中的那一刻——它就已经在你前面了。
>   Strong vs Infantry, Light Vehicles
>   Weak vs Tanks
>   Detected by: Infantry (1 cell), Turrets (2 cells), Outpost (5 cells)
>   Armor: None — 惧怕导弹、火炮

> **Stealth Raider Trike** — The forbidden fruit of Ixian technology. A Raider chassis wrapped in an adaptive camouflage net that bends Arrakis heat-shimmer. Infantry can spot it at arm's length. Gun turrets catch a silhouette at two car-lengths. Only an Outpost radar array gives warning at safe distance. The moment it vanishes from your rearview mirror — it's already in front of you.
>   Strong vs Infantry, Light Vehicles
>   Weak vs Tanks
>   Detected by: Infantry (1 cell), Turrets (2 cells), Outpost (5 cells)
>   Armor: None — vulnerable to missiles and cannons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-stealth-raider.name` | 当前: Invisible Raider\n Can be detected by Infantry (1 cell), Turrets(2 cells), Outpost (5 cells) | 自定义检测距离描述 |
| base: Stealth Raider Trike | base: Invisible Raider Trike.\n  Strong vs Infantry and Light Vehicles\n  Weak vs Tanks | |

---

## quad

**新 Description**

> **四轮导弹车** — "当你能扔两支火箭的时候为什么只扔一支？"阿拉基斯工程师的回答：在四轮底盘上焊了一个双管火箭发射架。装甲能扛住轻火力正面直击，火箭撕碎一切轻型装甲——但别让步兵靠太近，也别妄想打中正在跑的目标。
>   Strong vs Vehicles, Light Armor
>   Weak vs Infantry, Moving Targets
>   Armor: Light — 抵抗子弹、爆炸，惧怕导弹、火炮

> **Missile Quad** — "Why fire one rocket when you can fire two?" The Arrakis engineer's answer: a twin-tube launcher welded to a quad-wheel chassis. Light armor shrugs off small-arms fire. Rockets shred light vehicles. Just don't let infantry close the distance, and don't expect to hit anything that's running.
>   Strong vs Vehicles, Light Armor
>   Weak vs Infantry, Moving Targets
>   Armor: Light — resists bullets and explosives, vulnerable to missiles and cannons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-quad.name` | 当前: Missile Scout\n  Excellent vs Light Armor\n Modest vs Tanks\n Weak vs  Moving Targets, Infantry | |
| base: Missile Quad | base: Missile Scout.\n  Strong vs Vehicles\n  Weak vs Infantry | |

---

## heavy_quad

**新 Description**

> **重装四轮** — 三管齐射，装甲加固，速度略降。一把血统纯正的芬伦双管猎枪——只不过子弹是反装甲火箭。当普通四轮不够暴力的时，就叫它。
>   Strong vs Vehicles, Light Armor
>   Weak vs Infantry
>   Armor: Light — 抵抗子弹、爆炸，惧怕导弹、火炮

> **Heavy Quad** — Triple tubes, reinforced armor, slightly less speed. It's what happens when an ordnance tech looks at a standard Quad and says "one more." When the standard Quad isn't violent enough.
>   Strong vs Vehicles, Light Armor
>   Weak vs Infantry
>   Armor: Light — resists bullets and explosives, vulnerable to missiles and cannons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Heavy Quad | 当前: (无) | Enhanced11 独有 |
| base: (无此 unit) | base: (无) | |

---

## dustrider

**新 Description**

> **沙漠运输车** — 一个在沙漠风暴中出生的私生子：一半是装甲运兵，一半是机炮平台。能塞进四个步兵并碾过任何敢挡路的倒霉蛋。车顶机枪扫平轻甲，尾部火箭清理天空。当它被击毁，车厢里的人可能踉跄爬出残骸——但残骸周围的一切都不会有幸存的运气。
>   Strong vs Infantry, Light Vehicles, Air
>   Weak vs Tanks
>   Cargo: 4 infantry — 碾压步兵
>   Armor: Light — 惧怕导弹、火炮、音波

> **Dustrider** — A bastard child born in a sandstorm: half armored transport, half autocannon platform. Stuffs four infantry inside and crushes anyone foolish enough to stand in its path. Roof cannon for ground, tail rockets for sky. When it blows, the men inside might stumble out of the wreck — but nothing else in the blast radius gets that lucky.
>   Strong vs Infantry, Light Vehicles, Air
>   Weak vs Tanks
>   Cargo: 4 infantry — crushes infantry on contact
>   Armor: Light — vulnerable to missiles, cannons, and sonic weapons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Dustrider | 当前: Light transporter \n Can transport 4 infantry units. \n\n Can crush infantry | Enhanced11 独有 |
| base: (无此 unit) | base: (无) | |

---

## sand_runner

**新 Description**

> **沙漠奔袭者** — 精英弗瑞曼的专属座驾。把标准三轮摩托交给一个在沙漠深处长大的战士调校，给它装上旋转炮塔和真正的装甲——你就得到了一头能在沙丘表面滑翔、隐入热浪、然后在他选定的时刻撕开你侧翼的钢铁胡狼。只有跟随弗瑞曼支援队共同抵达的人才配驾驭它。
>   Strong vs Infantry, Light Vehicles
>   Weak vs Tanks
>   Special: 沙漠中隐形 · 仅随弗瑞曼支援队抵达 · 不可建造
>   Armor: Light — 惧怕导弹、火炮、音波

> **Sand Runner** — The personal chariot of elite Fremen warriors. Take a standard Trike, hand it to someone who grew up in the deep desert, bolt on a rotating turret and actual armor — now you have a jackal of steel that glides across dune surfaces, vanishes into heat-shimmer, and tears into your flank at the moment of his choosing. Only arrives with Fremen reinforcements. Only the worthy ride.
>   Strong vs Infantry, Light Vehicles
>   Weak vs Tanks
>   Special: Invisible on desert · Arrives with Fremen reinforcements · Cannot be built
>   Armor: Light — vulnerable to missiles, cannons, and sonic weapons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Sand Runner | 当前: (无) | Enhanced11 独有 |
| base: (无此 unit) | base: (无) | |
