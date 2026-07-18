# Structures 文本整理

Source: `structures.yaml` (Enhanced11) vs base d2k `fluent/rules.ftl`

> base d2k 原文来自 `G:\prj\OpenRA-Hacking\OpenRA-release-20250330\mods\d2k\fluent\rules.ftl`

---

## construction_yard

**新 Description**

> **建造场** — 一座城市的第一块骨头。它的炉膛里烧着预制梁架和施工蓝图，吐出一座又一座建筑，像播种一样在岩石上铺开文明的根系。打掉它，你就打掉了一整场战争。

> **Construction Yard** — The first bone of a city. Within its furnace burn prefabricated beams and construction blueprints, spitting out building after building, laying roots of civilization across the rock. Kill it, and you've killed the whole war.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Conyard (faction 变体) | 当前: `actor-construction-yard.description` (继承) | 缩写"Conyard" |
| base: Construction Yard | base: Produces structures. | |

---

## wind_trap

**新 Description**

> **捕风塔** — 阿拉基斯式优雅：地面上的巨型风斗将沙漠热风导入地下涡轮阵列，驱动发电机和湿度抽提器同时运转。电力与水——在别处是两座建筑，在这里是一体的生存命题。

> **Wind Trap** — Arrakis elegance: colossal surface scoops funnel desert thermals into underground turbine arrays, driving generators and humidity extractors in a single stroke. Power and water — elsewhere, two buildings. Here, one question of survival.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-wind-trap.name` (继承) | 当前: `actor-wind-trap.description` (继承) | |
| base: Wind Trap | base: Supplies power to other\nstructures. | |

---

## refinery

**新 Description**

> **香料精炼厂** — 矿车满载而归，驶入泊位，将粗香料倾倒进粉碎机的咽喉。精炼厂把沙子变成硬通货。一座精炼厂附赠一辆矿车——CHOAM 包邮，公会承运。

> **Spice Refinery** — The harvester returns full, docks, and pours raw spice down the crusher's throat. The Refinery turns sand into hard currency. One harvester included — delivered by the Guild, compliments of CHOAM.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-refinery.name` (继承) | 当前: `actor-refinery.description` (继承) | |
| base: Spice Refinery | base: Harvesters unload Spice here\nfor processing. | |

---

## refinery_inverted

**新 Description**

> **精炼厂(反向)** — 同样的铁壳，同样的碾磨机——只是泊位开在北侧。当标准精炼厂的朝向让你无法规划基地时，把它翻过来。

> **Refinery (Inverted)** — Same iron shell. Same crusher throat. The dock just opens from the north. When the standard Refinery faces the wrong way for your base layout, flip it.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Spice Refinery Inverted | 当前: Refinery with docking from north side | Enhanced11 独有变体 |
| base: (无此 unit) | base: (无) | |

---

## barracks

**新 Description**

> **兵营** — 沙漠上的第一课不在靶场——是学会怎么在烈日下站三小时不脱水。然后才是武器。

> **Barracks** — First lesson on Arrakis isn't the firing range. It's standing in the sun for three hours without collapsing from dehydration. Then come the guns.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-barracks.name` (继承) | 当前: `actor-barracks.description` (继承) | |
| base: Barracks | base: Trains infantry. | |

---

## light_factory

**新 Description**

> **轻工厂** — 钢顶棚下，一台台轻骨架载具被铆钉枪和扭矩扳手从零拼装成型。造的不是英雄，是斥候。不够重，不够慢，刚好够快。

> **Light Factory** — Under a steel canopy, light-frame vehicles are bolted together from nothing by rivet guns and torque wrenches. It doesn't build heroes. It builds scouts. Not heavy enough. Not slow enough. Just fast enough.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-light-factory.name` (继承) | 当前: `actor-light-factory.description` (继承) | |
| base: Light Factory | base: Produces light vehicles. | |

---

## outpost

**新 Description**

> **前哨站** — 沙漠上最先亮起的那盏雷达屏。通电之后，整张地图在静电噪点中浮现出来——敌人的基地在哪里，沙虫在哪里，你的末日在哪里。之前你是在盲打。现在你能看见了。

> **Outpost** — The first radar screen to light up on the sand. Once powered, the entire map resolves out of static — where the enemy base sits, where the worms are, where your doom is. Before, you were fighting blind. Now you can see.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-outpost.name` (继承) | 当前: `actor-outpost.description` (继承) | |
| base: Outpost | base: Provides a radar map of the battlefield.\nRequires power to operate. | |

---

## heavy_factory

**新 Description**

> **重工厂** — 它的钢结构在沙漠热浪里扭曲变形，即使在正午都能听到钢材疲劳的呻吟。履带碾过沙丘的声响最先从这里传出来——然后是炮管。

> **Heavy Factory** — Its steel frame warps in the desert heat, groaning with metal fatigue even at noon. The first sound of tracks crushing dunes comes from here. Then comes the cannon.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-heavy-factory.name` (继承) | 当前: `actor-heavy-factory.description` (继承) | |
| base: Heavy Factory | base: Produces heavy vehicles. | |

---

## high_tech_factory

**新 Description**

> **高科技工厂** — 伊克斯的灰色专利从这里走进天空。翅膀的制造者。翅膀在上方投下的——是炸弹、是音波、还是更多的钢铁——取决于谁买了那批货。

> **High Tech Factory** — Where grey Ixian patents walk into the sky. Maker of wings. What those wings drop — bombs, sound, or more steel — depends on who bought the shipment.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-high-tech-factory.name` (继承) | 当前: `actor-high-tech-factory.description` (继承) | |
| base: High Tech Factory | base: Unlocks advanced technology. | |

---

## repair_pad

**新 Description**

> **维修平台** — 一座悬浮在磁力起重机臂下的露天车间。打残的坦克开上来，起重机降下，铆钉枪尖叫十五秒，它又完整如初。

> **Repair Pad** — An open-air workshop suspended under a magnetic crane arm. Drive the wrecked tank onto the pad. The crane descends. Rivet guns scream for fifteen seconds. It rolls off whole.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-repair-pad.name` (继承) | 当前: `actor-repair-pad.description` (继承) | |
| base: Repair Pad | base: Repairs vehicles.\nAllows MCVs to be built. | |

---

## research_centre

**新 Description**

> **伊克斯研究中心** — 一座由灰色合约和专利壁垒围成的知识堡垒。每一条武器蓝图从这里流出时，都盖着伊克斯的印戳和一份二十页的保密协议。

> **IX Research Center** — A fortress of knowledge walled in grey contracts and patent barriers. Every weapon blueprint that leaves here carries an Ixian stamp and a twenty-page NDA.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-research-centre.name` (继承) | 当前: `actor-research-centre.description` (继承) | |
| base: IX Research Center | base: Unlocks advanced tanks. | |

---

## starport

**新 Description**

> **星港** — CHOAM 的定价时钟，公会的飞行时刻表，以及一片大到能让星际货运船降落的空地。它不造东西——它买东西。价格随市场波动，发货速度取决于轨道上的公会导航员有没有喝多香料啤酒。一张好订单能省掉十分钟的坦克生产线。

> **Starport** — A CHOAM pricing clock. A Guild flight schedule. And a patch of land big enough for an interstellar freighter to set down. It doesn't build anything — it buys. Prices move with the market. Delivery speed depends on whether the Guild Navigator in orbit had one spice beer too many. A good order saves ten minutes of tank production.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-starport.name` (继承) | 当前: `actor-starport.description` (继承) | |
| base: Starport | base: Dropzone for quick reinforcements, at a price. | |

---

## wall

**新 Description**

> **混凝土墙** — 炮弹撞上去会停下。导弹不会。

> **Concrete Wall** — Shells hit it and stop. Missiles don't.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-wall.name` (继承) | 当前: `actor-wall.description` (继承) | |
| base: Concrete Wall | base: Stops units and blocks enemy fire. | |

---

## silo

**新 Description**

> **香料仓库** — 沙漠上立着一座塔。里面是香料。没有别的。

> **Spice Silo** — A tower stands on the sand. Inside: spice. Nothing else.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-silo.name` (继承) | 当前: `actor-silo.description` (继承) | |
| base: Silo | base: Stores excess harvested Spice. | |

---

## medium_gun_turret

**新 Description**

> **机枪炮塔** — 混凝土掩体。自动瞄准。配穿甲弹。内置隐形探测器。任何靠近两格以内的东西在打出第一枪前就已经被它锁定了。

> **Gun Turret** — Concrete bunker. Auto-targeting. Armor-piercing rounds. Built-in cloak detector. Anything that walks within two cells is already locked before it fires its first shot.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-medium-gun-turret.name` (继承) | 当前: Defensive structure.\n  Modest vs everthing\n weak vs Tanks\n detects cloaked units in 2 cell range | 加了隐身检测 |
| base: Gun Turret | base: Defensive structure.\n  Strong vs Tanks\n  Weak vs Infantry and Aircraft | |

---

## large_gun_turret

**新 Description**

> **火箭炮塔** — 混凝土脑袋上伸着四根管。风从管口吹进去，发出沙漠最低频的哨响。只有在那声音突然停了的时候，远处的什么东西正在掉下来。

> **Rocket Turret** — A concrete head with four tubes. Wind blows through the barrels, the lowest whistle the desert knows. Only when that sound stops — something, somewhere, is falling.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-large-gun-turret.name` (继承) | 当前: Defensive structure.\n  Strong vs Tanks, Aircraft\n  Weak vs infantry\n\n  Requires power to operate. | 强弱与 base d2k 相反 |
| base: Rocket Turret | base: Defensive structure.\nRequires power to operate.\n  Strong vs Infantry and Aircraft\n  Weak vs Tanks | |

---

## palace.atreides

**新 Description**

> **亚崔迪宫殿** — 弗瑞曼人的脚印消失在沙漠深处。他们从地图边缘的沙尘暴里走出来。召唤尚未发出，他们已经听见。

> **Atreides Palace** — Fremen footprints vanish into the deep desert. They walk out of a dust storm at the map's edge. They heard the summons before it was sent.

| Support Power | Tooltip | Description |
|--------------|---------|-------------|
| Airstrike | Atreides Airstrike | 3 Bomb-armed ornithopters from map edge\nin snake formation. |
| Recruit Fremen | Recruit Fremen | 7 Fremen + 2 Sand Runners from map edge |

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Atreides Palace | 当前: Unlocks elite infantry and weapons. | |
| base: Palace | base: Unlocks elite infantry and weapons. | |

---

## palace.harkonnen

**新 Description**

> **哈肯尼宫殿** — 男爵的钢铁意志，比阿拉基斯上任何结构都阴沉。塔顶导弹发射井里躺着一枚"死亡之手"——原子集束弹头在目标上空分裂，落下的地方只剩玻璃。

> **Harkonnen Palace** — The Baron's will in steel, grimmer than any structure on Arrakis. A single Death Hand missile rests in the rooftop silo — an atomic cluster warhead splits above the target, and where it lands, only glass remains.

| Support Power | Tooltip | Description |
|--------------|---------|-------------|
| Death Hand | Death Hand | Launches an atomic missile at a target location |

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Harkonnen Palace | 当前: Unlocks elite infantry and weapons. | |
| base: Palace | base: Unlocks elite infantry and weapons. | |

---

## palace.ordos

**新 Description**

> **奥多斯宫殿** — 一颗冰封行星的商业分部，浓缩在一座沙丘建筑里。破坏者在这里等待——一颗只需要名字和目标的活体炸弹。

> **Ordos Palace** — A commercial branch office of a frozen planet, condensed into a single dune structure. The Saboteur waits here — a walking bomb that needs only a name and a target.

| Support Power | Tooltip | Description |
|--------------|---------|-------------|
| Airstrike | Ordos Airstrike | 6 Deviator ornithopters from map edge.\nFly to target then engage nearby enemies. |
| Recruit Saboteur | Recruit Saboteur | Permanently cloaked. Destroys buildings. Self-destruct deals 20000 damage in 6-cell radius. |

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Ordos Palace | 当前: Unlocks elite infantry and weapons. | |
| base: Palace | base: Unlocks elite infantry and weapons. | |

---

## palace.corrino

**新 Description**

> **皇帝宫殿** — 帝国在这里只有一道影子。但这道影子就够了。

> **Emperor Palace** — The Empire has only a shadow here. The shadow is enough.

| Support Power | Tooltip | Description |
|--------------|---------|-------------|
| Rally | Rally Sardaukars | Boost sardaukar morale and speed for short period of time |

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Emperor Palace | 当前: Unlocks elite infantry | 重命名 |
| base: Palace | base: Unlocks elite infantry and weapons. | |

---

## fremen_sietch

**新 Description**

> **弗瑞曼穴地** — 沙虫骑手的造物主之钩悬挂在入口。风从隧道深处呼出千年前的祈祷。

> **Fremen Sietch** — Maker hooks hang at the entrance. Wind exhales from tunnel depths, carrying thousand-year-old prayers.

| Support Power | Tooltip | Description |
|--------------|---------|-------------|
| Worm Rider | Worm rider | Deploy to ride worm. |

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Sietch | 当前: `actor-fremen-sietch.description` (继承) | 简化 Tooltip |
| base: Fremen Sietch | base: (无) | |

---

## upgrade.conyard

**新 Description**

> **建造场升级** — 把标准的混凝土配方替换成一种更密、更硬、在沙砾侵蚀下多撑三倍的混合材料。\n解锁：火箭炮塔。所有已建成的建筑获得结构性加固。

> **Construction Yard Upgrade** — Swaps the standard concrete formula for a denser, harder composite that withstands three times the grit erosion.\nUnlocks: Rocket Turret. All existing structures receive structural reinforcement.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-upgrade-conyard.name` (继承) | 当前: UPGRADE BUILDINGS ARMOR!!! \n Unlock Rocket Turret | |
| base: Construction Yard Upgrade | base: Unlocks additional construction options:\n- Large Concrete Slab\n- Rocket Turret | |

---

## upgrade.barracks

**新 Description**

> **兵营升级** — 更重的武器。更厚的战术手册。以及那些只有特定家族才被允许训练的名字。\n解锁：导弹兵，工程师。家族专属：沙槌兵（奥多斯）。家族专属：亚崔迪掷弹兵，哈肯尼萨督卡。

> **Barracks Upgrade** — Heavier weapons. Thicker tactical manuals. And the names that only certain Houses are permitted to train.\nUnlocks: Trooper, Engineer. Faction-specific: Thumper Infantry (Ordos). Faction-specific: Grenadier (Atreides)\nFaction-specific: Sardaukar (Harkonnen).

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-upgrade-barracks.name` (继承) | 当前: `actor-upgrade-barracks.description` (继承) | |
| base: Barracks Upgrade | base: Unlocks additional infantry:\n- Trooper\n- Engineer\n- Thumper Infantry\n\nRequired to unlock faction-specific infantry:\n- Atreides: Grenadier\n- Harkonnen: Sardaukar | |

---

## upgrade.light

**新 Description**

> **轻工厂升级** — 固定机炮被卸下来，旋转导弹发射架焊了上去。签了灰色条款的那家客户多拿了一份。\n解锁：四轮导弹车，沙漠运输车。家族专属：奥多斯隐形突袭三轮。

> **Light Factory Upgrade** — Fixed cannons come off. Rotating missile racks get welded on. The client with the grey contract clause received something extra.\nUnlocks: Missile Quad, Dustrider. Faction-specific: Stealth Raider Trike (Ordos).

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-upgrade-light.name` (继承) | 当前: `actor-upgrade-light.description` (继承) | |
| base: Light Factory Upgrade | base: Unlocks additional light units:\n- Missile Quad\n\nRequired to unlock a faction-specific light unit:\n- Ordos: Stealth Raider Trike | |

---

## upgrade.heavy

**新 Description**

> **重工厂升级** — 车间入口的牌子从"重型载具"换成了"战争机器"。\n解锁：维修平台，伊克斯研究中心，攻城坦克，MCV。导弹坦克（亚崔迪、哈肯尼；奥多斯通过星港采购）。家族专属：叛变者导弹车（奥多斯），音波坦克（亚崔迪），毁灭者（哈肯尼）。

> **Heavy Factory Upgrade** — The sign outside replaces "Heavy Vehicles" with "War Machines".\nUnlocks: Repair Pad, IX Research Center, Siege Tank, MCV. Missile Tank (Atreides, Harkonnen; Ordos via Starport). Faction-specific: Deviator (Ordos), Sonic Tank (Atreides), Devastator (Harkonnen).

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-upgrade-heavy.name` (继承) | 当前: `actor-upgrade-heavy.description` (继承) | |
| base: Heavy Factory Upgrade | base: Unlocks additional construction options:\n- Repair Pad\n- IX Research Center\n\nUnlocks additional heavy units:\n- Siege Tank\n- Missile Tank\n- MCV | |

---

## upgrade.starport

**新 Description**

> **星港升级** — CHOAM 的销售代表翻开了目录的下一页。上面写着"承包商"。下面全是标价。\n解锁：走私者援军，佣兵援军。

> **Starport Upgrade** — The CHOAM sales representative turns one more page in the catalogue. It says "Contractors." Everything below it has a price tag.\nUnlocks: Smugglers reinforcements.

| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: Starport upgrade | 当前: Unlocks Contractors | Enhanced11 独有 |
| base: (无此 unit) | base: (无) | |

---

## upgrade.hightech

**新 Description**

> **高科技工厂升级** — 只向两大家族敞开。\n解锁：空袭（亚崔迪），叛变者毒气空袭（奥多斯）。
> **High Tech Factory Upgrade** — Only two Houses are permitted through this door.\nUnlocks: Airstrike (Atreides), Deviator Airstrike (Ordos).
| Tooltip | Description | 备注 |
|---------|-------------|------|
| 当前: `actor-upgrade-hightech.name` (继承) | 当前: Unlocks Hight tech Support powers | |
| base: High Tech Factory Upgrade | base: Unlocks the Atreides Air Strike superweapon. | |
