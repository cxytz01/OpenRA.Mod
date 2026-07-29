# Infantry 文本整理

Source: `infantry.yaml` + `arrakis.yaml` (Enhanced11) vs base d2k `fluent/rules.ftl`

> base d2k 原文来自 `G:\prj\OpenRA-Hacking\OpenRA-release-20250330\mods\d2k\fluent\rules.ftl`

---

## light_inf

> **轻步兵** — 各大世族从附属行星征召的合同兵。配发 9mm RP 突击步枪与轻量化作战服，在对抗敌方步兵时堪堪够用。然而当装甲载具碾过沙丘、炮火开始落下时——祈祷是你唯一剩下的选择。
>   Strong vs Infantry
>   Weak vs Vehicles, Tanks, Artillery
>   Armor: 无 — 极度惧怕机枪、火焰、音波

> **Light Infantry** — Contract soldiers levied from the vassal worlds of the Great Houses. Issued a 9mm RP assault rifle and a lightweight combat vest, adequate enough for trading fire with other foot soldiers. But when an armored column crests the dune and the artillery finds its range — prayer is the only equipment left that matters.
>   Strong vs Infantry
>   Weak vs Vehicles, Tanks, Artillery
>   Armor: None — extremely vulnerable to machine guns, fire, and sonic weapons

---

## trooper

> **导弹兵** — "扛着管子的家伙活不长。"但在他倒下之前，他能把你的坦克变成一堆燃烧的废铁。双模武器系统：线导反坦克火箭打地面，热寻的防空导弹打天上。重甲让他能顶着轻火力站稳——但别让他暴露在步兵冲锋和炮火覆盖下。
>   Strong vs Tanks, Vehicles, Aircraft
>   Weak vs Infantry, Artillery
>   Armor: 无 — 惧怕机枪、火焰、音波

> **Trooper** — "The guy with the tube doesn't last long." But before he goes down, he'll turn your tank into a burning wreck. Dual-mode weapon system: wire-guided anti-tank rockets for ground targets, heat-seeking AA missiles for the sky. Heavy plating lets him shrug off light fire — but don't let him get caught in an infantry rush or an artillery barrage.
>   Strong vs Tanks, Vehicles, Aircraft
>   Weak vs Infantry, Artillery
>   Armor: None — vulnerable to machine guns, fire, and sonic weapons

---

## engineer

> **工程师** — 技术公会培养的战场技师，仅有一把防身手枪和一颗冷静的大脑。潜入占领敌方建筑，回收载具残骸，瞬间修复友方设施，重建坍塌崖壁。每个工程师值四百香料——别让他们死于流弹。
>   Strong vs Buildings
>   Weak vs Everything
>   Armor: 无 — 惧怕一切

> **Engineer** — Battlefield technician trained by the Technocrat Guild, armed with little more than a sidearm and a calm mind. Infiltrates and captures enemy structures. Reclaims vehicle husks from the sand. Repairs allied facilities in seconds. Rebuilds collapsed cliff passages. Every Engineer costs four hundred spice — don't let them die to a stray bullet.
>   Strong vs Buildings
>   Weak vs Everything
>   Armor: None — vulnerable to everything

---

## grenadier

> **掷弹兵** — 亚崔迪家族的近战爆破手。手雷抛越墙垣沙丘，将步兵和建筑化为血雾。弹带不稳定是设计缺陷——一名掷弹兵倒下，余弹同时引爆，让周围敌人陪葬。
>   Strong vs Buildings, Infantry
>   Weak vs Vehicles, Tanks
>   Armor: 无 — 惧怕机枪、火焰、音波
>   死亡爆炸：1600 伤害

> **Grenadier** — House Atreides close-quarters demolitions expert. Lobs fragmentation grenades over walls and dunes, turning infantry squads and structures into blood mist. Their ammo belts are notoriously unstable — a known design flaw. When one Grenadier falls, his remaining payload detonates, taking the surrounding enemy with him.
>   Strong vs Buildings, Infantry
>   Weak vs Vehicles, Tanks
>   Armor: None — vulnerable to machine guns, fire, and sonic weapons
>   Death explosion: 1600 damage

---

## fremen

> **弗瑞曼战士** — 沙漠化为人形。阿拉基斯原住民在连呼吸都会死的世界里锤炼千年，双持突击步枪与穿甲火箭，藏于蒸馏服下，与沙丘融为一体。他们不会被击败——只会退入风暴，在烈日下自愈，再次出现。从迦太格到厄拉肯，异星人用最低的声音念诵他们的名字。
>   Strong vs Infantry, Light Vehicles
>   Weak vs Artillery
>   Special: 沙漠中隐形 · 自动回复生命 · 不可建造

> **Fremen Warrior** — The desert itself, given human form. The native people of Arrakis, forged across millennia in a world where breathing alone can kill you. Dual-wielding 10mm assault rifles and armor-piercing rockets, concealed beneath stillsuits, indistinguishable from the dune itself. They are never truly defeated — they retreat into the storm, heal beneath the twin suns, and return. From Carthag to Arakeen, every offworlder speaks their name in the lowest whisper.
>   Strong vs Infantry, Light Vehicles
>   Weak vs Artillery
>   Special: Invisible on desert · Auto-regenerates health · Cannot be built

---

## sardaukar

> **萨督卡** — 帕迪沙皇帝之刃，萨鲁萨塞康达斯炼狱星上铸造的活体兵器。轻机枪收割步兵潮；重机枪撕碎装甲列。当集结号吹响，他们放弃掩体，化作狂怒潮水碾过战场。六世纪来，无人正面击败萨督卡军团。
>   Strong vs Infantry, Vehicles
>   Weak vs Artillery, Sonic Beams
>   Special: Rally 集结令 — 提升至精英等级

> **Sardaukar** — The blade of the Padishah Emperor, living weapons forged on the hell-prison world of Salusa Secundus. Light machine gun scythes through infantry waves; heavy machine gun tears through armor columns. Their loyalty to the Golden Lion Throne is absolute — when the rally horn sounds, they abandon cover and become a tide of steel and fury. For six centuries, no one has defeated the Sardaukar legions in a stand-up fight.
>   Strong vs Infantry, Vehicles
>   Weak vs Artillery, Sonic Beams
>   Special: Rally — elevated to elite rank; abandons cover, gains speed and morale

---

## saboteur

> **破坏者** — 奥多斯影子特工。体内植入等离子核心，包裹在伊克斯永久隐形力场中。悄无声息穿越防线，走入目标建筑，起爆。方圆六格，寸草不留。即使被击杀，殉爆让周围敌人陪葬。
>   Strong vs Buildings
>   Weak vs Everything
>   Special: 永久隐形 · 接触摧毁建筑 · 死亡时爆炸

> **Saboteur** — A shadow agent of House Ordos. A plasma-core explosive is surgically implanted within their body, shielded by a permanent Ixian cloaking field that no detector can pierce. They slip through defensive lines unseen, enter the target structure, and trigger the detonator. Six cells of annihilation. Nothing remains. Even if discovered and gunned down, the dead-man's switch ensures the blast still claims everything nearby.
>   Strong vs Buildings
>   Weak vs Everything
>   Special: Permanently cloaked · Destroys buildings on contact · Explodes when killed

---

## thumper

> **沙槌兵** — 一个勇敢的——或被判死刑的——灵魂，背负锤击器走入沙漠。沙槌敲击沙层，震颤在沙丘下传播数公里。它不是武器；是一份请柬。赴约的，是沙胡鲁德——沙漠老人——从地底升起，吞噬一切。
>   Unarmed
>   Special: 部署召唤沙虫

> **Thumper Infantry** — A brave — or condemned — soul, carrying a pile-driver deep into the open desert. The thumper hammers the sand, its tremor traveling for kilometers beneath the dunes. It is not a weapon. It is an invitation. The guest who answers is Shai-Hulud — the Old Man of the Desert — rising from below to consume everything at the thumper's location.
>   Unarmed
>   Special: Deploy to summon a colossal sandworm

---

## worm_rider

> **沙虫骑手** — 通过终极试炼的弗瑞曼耐布：驾驭沙胡鲁德。手握造物主之钩与千年沙漠秘识，召唤并骑乘沙虫，驱使巨兽冲向敌方阵列。地平线上出现沙虫骑手剪影之时——沙漠已向你宣战。
>   Unarmed
>   Special: 部署召唤并骑乘沙虫

> **Worm Rider** — A Fremen Naib who has passed the ultimate trial: to master Shai-Hulud. With maker hooks in hand and the desert-lore of a thousand generations, they anchor the hooks into the sand, call forth a sandworm, mount the great beast, and ride it into the enemy line. When the silhouette of a Worm Rider appears on the horizon — know this: the desert itself has declared war upon you.
>   Unarmed
>   Special: Deploy to summon and mount a sandworm
