# Tanks 文本整理

Source: `tanks.yaml` (Enhanced11) vs base d2k `fluent/rules.ftl`

> base d2k 原文来自 `G:\prj\OpenRA-Hacking\OpenRA-release-20250330\mods\d2k\fluent\rules.ftl`
> 注：base d2k 中 mcv, harvester, combat_tank 等也在 `vehicles.yaml`

---

## mcv

**新 Description**

> **移动建造载具** — 帝国重工的终极结晶，一个轮子上的文明种子。没有武器。没有装甲可言——至少不是你在坦克上看到的那种。但它肚子里装着一整套可展开的预制构造厂。把它开到一片平坦的岩石上，展开，然后你就拥有了一座城市的第一块骨头。保护它，不惜一切代价。
>   Unarmed
>   Special: 部署为建造场
>   Armor: Light — 惧怕导弹、火炮

> **Mobile Construction Vehicle** — The crowning achievement of Imperial heavy engineering: a civilization seed on wheels. Unarmed. Barely armored — at least not in a tank way. But it carries a fully prefabricated Construction Yard inside. Drive it onto flat rock. Deploy. Now you have the first bone of a city. Protect it at any cost.
>   Unarmed
>   Special: Deploys into a Construction Yard
>   Armor: Light — vulnerable to missiles and cannons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-mcv.name` | 当前: `actor-mcv.description` | |
| base: Mobile Construction Vehicle | base: Deploys into a Construction Yard.\n  Unarmed | |

---

## harvester

**新 Description**

> **香料采集车** — 阿拉基斯的生命线，一个庞大缓慢的履带巨兽，专门吞食沙层表面富含香料的矿脉。没有武器，但它也不需要——光是它碾压过来时你都够呛了。被毁时，货舱里残余的压缩香料会掀起一场令整个屏幕震颤的橘色末日。
>   Unarmed
>   Special: 采集香料 · 死亡爆炸造成大范围伤害
>   Armor: Heavy — 抵抗子弹、爆炸，惧怕导弹、火炮

> **Spice Harvester** — The lifeblood of Arrakis: a vast, slow-moving tracked beast designed to devour the spice-rich surface layers of the dunes. Unarmed. It doesn't need guns — you'll have enough trouble getting out of its way. When destroyed, the compressed-spice cargo ignites into an apocalyptic orange fireball that every unit on the battlefield will feel.
>   Unarmed
>   Special: Harvests Spice · Massive death explosion
>   Armor: Heavy — resists bullets and explosives, vulnerable to missiles and cannons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-harvester.name` | 当前: Collects Spice for processing\n  Explode after death | 加了"Explode after death"，删了"Unarmed" |
| base: Spice Harvester | base: Collects Spice for processing.\n  Unarmed | |

---

## siege_tank

**新 Description**

> **攻城坦克** — 一根架在履带上的 155mm 榴弹炮管，专门向地平线那边投掷高爆问候。打不打得中是另一个问题——精度从来不是卖点。但一旦命中，步兵和建筑就像盐撒在伤口上一样消失。
>   Strong vs Infantry, Buildings
>   Weak vs Tanks, Moving Targets
>   Long range, high inaccuracy — 最低射程限制
>   Armor: Light — 惧怕导弹、音波

> **Siege Tank** — The bluntest siege instrument a 155mm howitzer tube on tracks, lobbing high-explosive greetings over the horizon. Hitting anything is a different matter — accuracy was never a design goal. But when it connects, infantry and buildings dissolve like salt on an open wound. 
>   Strong vs Infantry, Buildings
>   Weak vs Tanks, Moving Targets
>   Long range, high inaccuracy — minimum range
>   Armor: Light — vulnerable to missiles and sonic weapons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-siege-tank.name` | 当前: Siege Artillery\n  High range, high Inaccuracy\n Strong vs Infantry, Buildings\n  Weak vs Tanks | 加了"High range, high Inaccuracy" |
| base: Siege Tank | base: Siege Artillery.\n  Strong vs Infantry and Buildings\n  Weak vs Tanks | |

---

## missile_tank

**新 Description**

> **导弹坦克** — "把两枚制导火箭塞进一个旋转发射架，告诉车组'打一切'。"它确实打一切：天上的、地上的、跑路的。步兵除外。步兵太灵活了，导弹从他们头顶掠过却什么都打不中。
>   Strong vs Vehicles, Tanks, Aircraft, Moving Targets
>   Weak vs Infantry
>   Armor: Wood — 惧怕大多数武器，唯对爆炸与火焰稍具抗性

> **Missile Tank** — "Bolt two guided rockets into a rotating launcher, point at everything, fire." It hits everything: air, ground, running, hiding. Except infantry. Infantry are too nimble. The missiles scream overhead and find nothing but sand.
>   Strong vs Vehicles, Tanks, Aircraft, Moving Targets
>   Weak vs Infantry
>   Armor: Wood — vulnerable to most weapons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-missile-tank.name` | 当前: Rocket Artillery\n Excellent vs moving targets, Tanks\n Strong vs Vehicles, Aircraft\n  Weak vs Infantry | |
| base: Missile Tank | base: Rocket Artillery.\n  Strong vs Vehicles, Buildings and Aircraft\n  Weak vs Infantry | |

---

## deviator

**新 Description**

> **叛变者导弹车** — 奥多斯最令人不安的发明。一枚包裹着硅基神经毒气云的导弹，穿透敌军装甲，短暂劫持车组人员的忠诚。上一秒他还在打你，下一秒他就在打他的朋友。残骸泄漏的毒气会继续扩散——不要靠近，无论残骸属于哪一方。
>   Strong vs Vehicles, Tanks
>   Weak vs Everything else
>   Special: 命中后转化敌方载具 · 残骸泄漏毒气
>   Armor: Light — 惧怕导弹、音波

> **Deviator** — The most unsettling invention in the Ordos arsenal. A missile wrapped in a cloud of silicon-based neuro-gas that slips through enemy armor and temporarily rewrites the crew's loyalty. One moment he's shooting at you. The next, he's shooting at his friends. The wreck leaks gas that lingers — stay away, no matter whose side the husk is on.
>   Strong vs Vehicles, Tanks
>   Weak vs Everything else
>   Special: Converts enemy vehicles on hit · Wreck leaks allegiance-changing gas
>   Armor: Light — vulnerable to missiles and sonic weapons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-deviator.name` | 当前: Fires a Gas which changes\nthe allegiance of enemy vehicles\n Gas leaks from Deviator husk dead\n weak vs everythink | 加了 gas leak 描述 |
| base: Deviator | base: Fires a warhead that changes the\nallegiance of enemy vehicles. | |

---

## sonic_tank

**新 Description**

> **音波坦克** — 亚崔迪的声学噩梦，由伊克斯研究中心解锁的重型工程。一束超振幅声波从炮口射出，穿过一切——友军、敌军、墙壁、沙丘——持续杀伤直到能量衰减殆尽。最可怕的不是它在杀人；而是它不在乎杀谁。
>   Strong vs Infantry, Vehicles, Buildings
>   Weak vs Tanks, Artillery
>   Special: 穿透攻击 — 伤害路径上一切 · 友军火力
>   Armor: Light — 抵抗子弹、爆炸，惧怕导弹、火炮

> **Sonic Tank** — The acoustic nightmare of House Atreides, unlocked by IX Research. A hyper-amplified sound beam pours from the cannon, passing through everything — friend, foe, wall, dune — killing continuously until the energy dissipates. The most terrifying thing isn't that it kills. It's that it doesn't care who.
>   Strong vs Infantry, Vehicles, Buildings
>   Weak vs Tanks, Artillery
>   Special: Piercing attack — damages everything in beam path · Friendly fire
>   Armor: Light — resists bullets and explosives, vulnerable to missiles and cannons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-sonic-tank.name` | 当前: Fires sonic shocks\n  Excellent vs Infantry, Vehicles, Buildings\n Modest vs vehicles \n  Weak vs Tanks\n Friendly Fire | 弱点改为"Tanks"，加"Friendly Fire" |
| base: Sonic Tank | base: Fires sonic shocks.\n  Strong vs Infantry and Vehicles\n  Weak vs Artillery | |

---

## devastator

**新 Description**

> **毁灭者** — 哈肯尼的钢铁宣言。阿拉基斯上最重的作战坦克，双联等离子炮在开火时让空气电离，履带碾过岩石时地面下沉。当伤势过重无法继续战斗时，车组成员会激活融合过载——反应堆临界自毁，五格半径内只剩下熔化的玻璃。荣耀。或者疯狂。有时两者是一回事。
>   Strong vs Everything
>   Weak vs Infantry, Artillery
>   Special: 融合过载 — 自毁，半径 5.5 格等离子爆炸
>   Armor: Heavy — 极度耐打，惧怕导弹

> **Devastator** — House Harkonnen's statement in steel. The heaviest battle tank on Arrakis. Twin plasma cannons ionize the air when they fire. The ground sinks when it moves. When damage is too severe to continue, the crew activates fusion overload — the reactor goes critical and detonates. Five and a half cells of melted glass remain. Glory. Or madness. Sometimes they're the same thing.
>   Strong vs Everything
>   Weak vs Infantry, Artillery
>   Special: Fusion overload — self-destruct for massive plasma explosion (5.5 cell radius)
>   Armor: Heavy — extremely durable, vulnerable to missiles

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-devastator.name` | 当前: Super Heavy Tank\n  Decent damage vs everthing\n weak vs Infantry \n SelfDestruction damage 5.5 square cells | |
| base: Devastator | base: Super Heavy Tank.\n  Strong vs Tanks\n  Weak vs Artillery | |

---

## combat_tank_a

**新 Description**

> **亚崔迪战斗坦克** — "平衡"在战场上意味着"平庸"——直到工程师把炮管加长 30%。标准装甲，标准速度，但射程比哈肯尼和奥多斯多出一截。卡尔丹水世界赋予亚崔迪人的不是蛮力，而是耐心。让你的敌人先冲。然后在他还没进射程的时候就拆了他。
>   Strong vs Tanks, Vehicles
>   Weak vs Infantry
>   Longer range than other Combat Tanks
>   Armor: Heavy — 抵抗子弹、爆炸，惧怕导弹

> **Atreides Combat Tank** — "Balanced" means "mediocre" on a battlefield — until the engineers extend the barrel by thirty percent. Standard armor. Standard speed. But it reaches out further than the Harkonnen or Ordos variants. The water world of Caladan didn't breed brute force. It bred patience. Let the enemy charge. Then dismantle him before he enters firing range.
>   Strong vs Tanks, Vehicles
>   Weak vs Infantry
>   Longer range than other Combat Tanks
>   Armor: Heavy — resists bullets and explosives, vulnerable to missiles

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Atreides Combat Tank | 当前: Atreides Combat Tank \n Modest speed/HP \n Longer Range | faction 特定描述 |
| base: Atreides Combat Tank | base: `meta-combat-tank-description`\nMain Battle Tank.\n  Strong vs Tanks\n  Weak vs Infantry | |

---

## combat_tank_h

**新 Description**

> **哈肯尼战斗坦克** — 乔第主星的工业熔炉吐出的铁块。最重，最慢。给舱盖焊上额外钢板，调低引擎限速器——然后告诉车组，只要引擎还能动，速度就不会再掉。哈肯尼不撤退。哈肯尼推过去。
>   Strong vs Tanks, Vehicles
>   Weak vs Infantry
>   More HP, lower speed — 低血量时不减速
>   Armor: Heavy — 极度耐打，惧怕导弹

> **Harkonnen Combat Tank** — A slab of iron spat from the industrial furnaces of Giedi Prime. Heaviest. Slowest. Extra armor plating welded to the hatch. Engine limiter tuned down — the crew gets told that speed penalties don't apply as long as the engine still turns. Harkonnen doesn't retreat. Harkonnen pushes through.
>   Strong vs Tanks, Vehicles
>   Weak vs Infantry
>   More HP, lower speed — less speed penalty on low HP
>   Armor: Heavy — extremely durable, vulnerable to missiles

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Harkonnen Combat Tank | 当前: Harkonnen Combat tank \n More Healt, low Speed \n Less speed penalty when on low HP | faction 特定描述 |
| base: Harkonnen Combat Tank | base: `meta-combat-tank-description`\nMain Battle Tank.\n  Strong vs Tanks\n  Weak vs Infantry | |

---

## combat_tank_o

**新 Description**

> **奥多斯战斗坦克** — 最快、最轻、最危险——对自己和敌人都危险。奥多斯让伊克斯减重了底盘、加速了炮塔电机、调高了射速——代价是装甲薄得像吉普。但如果战争拖得够久，射速总能赢。
>   Strong vs Tanks, Vehicles
>   Weak vs Infantry
>   Faster speed, lower HP — 更高射速
>   Armor: Heavy — 三族中最轻的重甲，惧怕导弹

> **Ordos Combat Tank** — Fastest. Lightest. Most dangerous — to itself and to the enemy. Ordos paid Ix to strip weight from the chassis, overclock the turret motor, and bump the fire rate. The cost is armor thin enough to worry about. But if the war lasts long enough — rate of fire always wins.
>   Strong vs Tanks, Vehicles
>   Weak vs Infantry
>   Faster speed, lower HP — higher rate of fire
>   Armor: Heavy — lightest of the three, vulnerable to missiles

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Ordos Combat Tank | 当前: Ordos tank \n Fast speed, low HP \n Combat Bonus: Rate of fire | faction 特定描述 |
| base: Ordos Combat Tank | base: `meta-combat-tank-description`\nMain Battle Tank.\n  Strong vs Tanks\n  Weak vs Infantry | |

---

## bison_tank

**新 Description**

> **野牛坦克** — 伊克斯许可的双管重型坦克。连发两炮，装弹，再开两炮。当四轮已经不够威力而毁灭者又太贵的时候，就是你买野牛的时候。对装甲列队和防御工事有奇效。
>   Strong vs Vehicles, Tanks, Defenses
>   Weak vs Infantry
>   Double-barrel — 双发连射
>   Armor: Heavy — 极度耐打，惧怕导弹

> **Bison Tank** — Ixian-licensed heavy tank with twin barrels. Two shots. Reload. Two more. When the Quad isn't enough and the Devastator is too expensive, you buy the Bison. Devastating against armored columns and defensive structures.
>   Strong vs Vehicles, Tanks, Defenses
>   Weak vs Infantry
>   Double-barrel — fires two shots per salvo
>   Armor: Heavy — extremely durable, vulnerable to missiles

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Bison tank | 当前: Heavy double barrel tank licensed from IX \n Strong VS vehicles, Tanks, Defences \n Weak VS infantry | Enhanced11 独有 |
| base: (无此 unit) | base: (无) | |

---

## bombardment_tank

**新 Description**

> **炮击坦克** — 伊克斯重工的另一件作品：一个能打出导弹弹幕的移动炮台。四枚齐射，然后是漫长到令人心焦的装填时间。偏得离谱。慢得发指。但当四枚导弹全部同时落在同一个建筑群上时，没有任何东西能站在那里。
>   Strong vs Infantry, Buildings, Light Armor
>   Weak vs Tanks, Moving Targets
>   Special: 4 发齐射后需重新装填 · 高散布
>   Armor: Light — 惧怕导弹、火炮

> **Bombardment Tank** — Another Ixian heavy engineering piece: a mobile battery that vomits a barrage of missiles. Four rockets gone in a salvo, then an agonizingly long reload. Wildly inaccurate. Painfully slow. But when all four missiles land on the same building complex at the same time, nothing is standing anymore.
>   Strong vs Infantry, Buildings, Light Armor
>   Weak vs Tanks, Moving Targets
>   Special: 4-rocket salvo, then reload · High inaccuracy
>   Armor: Light — vulnerable to missiles and cannons

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Bombardment Tank | 当前: Heavy missile barrage affecting large area. \n Strong VS Infantry, Light armor \n Weak VS moving targets, tanks \n Ability: can fire 4 missile before reload \n High inaccuraty | Enhanced11 独有 |
| base: (无此 unit) | base: (无) | |

---

## scorch_tank

**新 Description**

> **焦土战车** — 哈肯尼军事美学的完美表达：在坦克上装一个巨型火焰喷射器。步兵？化为灰烬。建筑？燃烧的废墟。香料田？付之一炬——连带正在采集的敌方矿车一起。近距离接触它会触发储油罐爆炸。从远处打。从非常、非常远的地方打。
>   Strong vs Infantry, Buildings
>   Weak vs Tanks, Defenses
>   Special: 摧毁香料 · 死亡时油箱爆炸
>   Armor: Light — 惧怕导弹

> **Scorch Tank** — The perfect expression of Harkonnen military aesthetics: a giant flamethrower mounted on a tank chassis. Infantry? Ash. Buildings? Burning ruins. Spice fields? Set ablaze — along with any enemy harvester working them. Getting close triggers its fuel-tank explosion. Kill it from a distance. A very, very long distance.
>   Strong vs Infantry, Buildings
>   Weak vs Tanks, Defenses
>   Special: Destroys Spice · Fuel tank explosion on death
>   Armor: Light — vulnerable to missiles

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Scorch Tank | 当前: Scorch Tank \n Strong VS Infantry, Buildings \n Weak VS Tanks, Defenses \n Destroy spice | Enhanced11 独有 |
| base: (无此 unit) | base: (无) | |
