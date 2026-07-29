## infantry.yaml - Enhanced11 descriptions

light-inf =
    .description =
    Contract soldiers levied from the vassal worlds of the Great Houses. Issued a 9mm RP assault rifle
    and a lightweight combat vest, adequate enough for trading fire with other foot soldiers. But when
    an armored column crests the dune and the artillery finds its range — prayer is the only equipment
    left that matters.
      Strong vs Infantry
      Weak vs Vehicles, Tanks, Artillery
      Armor: None — extremely vulnerable to machine guns, fire, and sonic weapons

trooper =
    .description =
    "The guy with the tube doesn't last long." But before he goes down, he'll turn your tank into
    a burning wreck. Dual-mode weapon system: wire-guided anti-tank rockets for ground targets,
    heat-seeking AA missiles for the sky. Heavy plating lets him shrug off light fire — but don't
    let him get caught in an infantry rush or an artillery barrage.
      Strong vs Tanks, Vehicles, Aircraft
      Weak vs Infantry, Artillery
      Armor: None — vulnerable to machine guns, fire, and sonic weapons

engineer =
    .description =
    Battlefield technician trained by the Technocrat Guild, armed with little more than a sidearm
    and a calm mind. Infiltrates and captures enemy structures. Reclaims vehicle husks from the sand.
    Repairs allied facilities in seconds. Rebuilds collapsed cliff passages. Every Engineer costs
    four hundred spice — don't let them die to a stray bullet.
      Unarmed
      Strong vs Buildings
      Weak vs Everything
      Armor: None — vulnerable to everything

grenadier =
    .description =
    House Atreides close-quarters demolitions expert. Lobs fragmentation grenades over walls and dunes,
    turning infantry squads and structures into blood mist. Their ammo belts are notoriously unstable —
    a known design flaw. When one Grenadier falls, his remaining payload detonates, taking the
    surrounding enemy with him.
      Strong vs Buildings, Infantry
      Weak vs Vehicles, Tanks
      Armor: None — vulnerable to machine guns, fire, and sonic weapons
      Death explosion: 1600 damage

fremen =
    .description =
    The desert itself, given human form. The native people of Arrakis, forged across millennia in
    a world where breathing alone can kill you. Dual-wielding 10mm assault rifles and armor-piercing
    rockets, concealed beneath stillsuits, indistinguishable from the dune itself. They are never truly
    defeated — they retreat into the storm, heal beneath the twin suns, and return. From Carthag to
    Arakeen, every offworlder speaks their name in the lowest whisper.
      Strong vs Infantry, Light Vehicles
      Weak vs Artillery
      Special: Invisible on desert · Auto-regenerates health · Cannot be built

sardaukar =
    .description =
    The blade of the Padishah Emperor, living weapons forged on the hell-prison world of Salusa Secundus.
    Light machine gun scythes through infantry waves; heavy machine gun tears through armor columns.
    Their loyalty to the Golden Lion Throne is absolute — when the rally horn sounds, they abandon cover
    and become a tide of steel and fury. For six centuries, no one has defeated the Sardaukar legions
    in a stand-up fight.
      Strong vs Infantry, Vehicles
      Weak vs Artillery, Sonic Beams
      Special: Rally — elevated to elite rank; abandons cover, gains speed and morale

saboteur =
    .description =
    A shadow agent of House Ordos. A plasma-core explosive is surgically implanted within their body,
    shielded by a permanent Ixian cloaking field that no detector can pierce. They slip through defensive
    lines unseen, enter the target structure, and trigger the detonator. Six cells of annihilation.
    Nothing remains. Even if discovered and gunned down, the dead-man's switch ensures the blast still
    claims everything nearby.
      Strong vs Buildings
      Weak vs Everything
      Special: Permanently cloaked · Destroys buildings on contact · Explodes when killed

## arrakis.yaml - Enhanced11 descriptions

thumper =
    .description =
    A brave — or condemned — soul, carrying a pile-driver deep into the open desert. The thumper
    hammers the sand, its tremor traveling for kilometers beneath the dunes. It is not a weapon. It is an
    invitation. The guest who answers is Shai-Hulud — the Old Man of the Desert — rising from below to
    consume everything at the thumper's location.
      Unarmed
      Weak vs Everything
      Special: Deploy to summon a colossal sandworm

worm-rider-desc =
    .description =
    A Fremen Naib who has passed the ultimate trial: to master Shai-Hulud. With maker hooks in hand
    and the desert-lore of a thousand generations, they anchor the hooks into the sand, call forth a
    sandworm, mount the great beast, and ride it into the enemy line. When the silhouette of a Worm
    Rider appears on the horizon — know this: the desert itself has declared war upon you.
      Unarmed
      Weak vs Everything
      Special: Deploy to summon and mount a sandworm

## vehicles.yaml - Enhanced11 descriptions

trike =
    .description =
    The light cavalry of the Arrakis battlefield. Three oversized tires, a heavy machine gun, and
    an armor plate so thin you won't notice when it gets punched through. Fast enough to drift through
    spice-dust corners, perfect for scouting and hit-and-run raids. Just don't let it meet anything
    bigger than itself.
      Strong vs Infantry
      Weak vs Tanks, Rockets
      Armor: Wood — vulnerable to missiles, cannons, and sonic weapons

raider =
    .description =
    House Ordos "business upgrade" to the standard Trike. Twin 20mm cannons. An acceleration tuning circulating only
    through the black markets of Sigma Draconis IV. Zero armor — yes, literally none — but when you're faster than
    the bullets, you don't need it as much. The engine howl is a psychological weapon all by itself.
      Strong vs Infantry, Light Vehicles
      Weak vs Tanks, Rockets
      Armor: None — extremely vulnerable to all fire

stealth-raider =
    .description =
    The forbidden fruit of Ixian technology. A Raider chassis wrapped in an adaptive camouflage net that
    bends Arrakis heat-shimmer. Infantry can spot it at arm's length. Gun turrets catch a silhouette at
    two car-lengths. Only an Outpost radar array gives warning at safe distance. The moment it vanishes
    from your rearview mirror — it's already in front of you.
      Strong vs Infantry, Light Vehicles
      Weak vs Tanks
      Detected by: Infantry (1 cell), Turrets (2 cells), Outpost (5 cells)
      Armor: None — vulnerable to missiles and cannons

quad =
    .description =
    "Why fire one rocket when you can fire two?" The Arrakis engineer's answer: a twin-tube launcher
    welded to a quad-wheel chassis. Light armor shrugs off small-arms fire. Rockets shred light vehicles.
    Just don't let infantry close the distance, and don't expect to hit anything that's running.
      Strong vs Vehicles, Light Armor
      Weak vs Infantry, Moving Targets
      Armor: Light — resists bullets and explosives, vulnerable to missiles and cannons

heavy-quad-desc =
    .description =
    Triple tubes, reinforced armor, slightly less speed. It's what happens when an ordnance tech
    looks at a standard Quad and says "one more." When the standard Quad isn't violent enough.
      Strong vs Vehicles, Light Armor
      Weak vs Infantry
      Armor: Light — resists bullets and explosives, vulnerable to missiles and cannons

dustrider =
    .description =
    A bastard child born in a sandstorm: half armored transport, half autocannon platform. Stuffs four
    infantry inside and crushes anyone foolish enough to stand in its path. Roof cannon for ground, tail
    rockets for sky. When it blows, the men inside might stumble out of the wreck — but nothing else in
    the blast radius gets that lucky.
      Strong vs Infantry, Light Vehicles, Air
      Weak vs Tanks
      Cargo: 4 infantry — crushes infantry on contact
      Armor: Light — vulnerable to missiles, cannons, and sonic weapons

sand-runner-desc =
    .description =
    The personal chariot of elite Fremen warriors. Take a standard Trike, hand it to someone who grew up
    in the deep desert, bolt on a rotating turret and actual armor — now you have a jackal of steel that
    glides across dune surfaces, vanishes into heat-shimmer, and tears into your flank at the moment of
    his choosing. Only arrives with Fremen reinforcements. Only the worthy ride.
      Strong vs Infantry, Light Vehicles
      Weak vs Tanks
      Special: Invisible on desert · Arrives with Fremen reinforcements · Cannot be built
      Armor: Light — vulnerable to missiles, cannons, and sonic weapons

## tanks.yaml - Enhanced11 descriptions

mcv =
    .description =
    The crowning achievement of Imperial heavy engineering: a civilization seed on wheels. Unarmed. Barely
    armored — at least not in a tank way. But it carries a fully prefabricated Construction Yard inside.
    Drive it onto flat rock. Deploy. Now you have the first bone of a city. Protect it at any cost.
      Unarmed
      Special: Deploys into a Construction Yard
      Armor: Light — vulnerable to missiles and cannons

harvester =
    .description =
    The lifeblood of Arrakis: a vast, slow-moving tracked beast designed to devour the spice-rich surface
    layers of the dunes. Unarmed. It doesn't need guns — you'll have enough trouble getting out of its
    way. When destroyed, the compressed-spice cargo ignites into an apocalyptic orange fireball that
    every unit on the battlefield will feel.
      Unarmed
      Special: Harvests Spice · Massive death explosion
      Armor: Heavy — resists bullets and explosives, vulnerable to missiles and cannons

siege-tank =
    .description =
    The bluntest siege instrument a 155mm howitzer tube on tracks, lobbing high-explosive greetings
    over the horizon. Hitting anything is a different matter — accuracy was never a design goal. But
    when it connects, infantry and buildings dissolve like salt on an open wound.
      Strong vs Infantry, Buildings
      Weak vs Tanks, Moving Targets
      Long range, high inaccuracy — minimum range
      Armor: Light — vulnerable to missiles and sonic weapons

missile-tank =
    .description =
    "Bolt two guided rockets into a rotating launcher, point at everything, fire." It hits everything:
    air, ground, running, hiding. Except infantry. Infantry are too nimble. The missiles scream overhead
    and find nothing but sand.
      Strong vs Vehicles, Tanks, Aircraft, Moving Targets
      Weak vs Infantry
      Armor: Wood — vulnerable to most weapons

deviator =
    .description =
    The most unsettling invention in the Ordos arsenal. A missile wrapped in a cloud of crystalline
    neuro-toxin that slips through enemy armor and temporarily rewrites the crew's loyalty. One moment
    he's shooting at you. The next, he's shooting at his friends. The wreck leaks gas that lingers —
    stay away, no matter whose side the husk is on.
      Strong vs Vehicles, Tanks
      Weak vs Everything else
      Special: Converts enemy vehicles on hit · Wreck leaks allegiance-changing gas
      Armor: Light — vulnerable to missiles and sonic weapons

sonic-tank =
    .description =
    The acoustic nightmare of House Atreides, unlocked by IX Research. A hyper-amplified sound beam
    pours from the cannon, passing through everything — friend, foe, wall, dune — killing continuously
    until the energy dissipates. The most terrifying thing isn't that it kills. It's that it doesn't
    care who.
      Strong vs Infantry, Vehicles, Buildings
      Weak vs Tanks, Artillery
      Special: Piercing attack — damages everything in beam path · Friendly fire
      Armor: Light — resists bullets and explosives, vulnerable to missiles and cannons

devastator-desc =
    .description =
    The Harkonnen Devastator was not built to win wars. It was built to convince the enemy that war can only end
    in annihilation. Twin plasma cannons tear through armor; the reactor becomes a bomb in its final moment.
    In Harkonnen's military doctrine, death is not defeat — it is merely the final offensive.
      Strong vs Everything
      Weak vs Infantry, Artillery
      Special: Fusion overload — self-destruct for massive plasma explosion (5.5 cell radius)
      Armor: Heavy — extremely durable, vulnerable to missiles

combat-tank-a =
    .description =
    "Balanced" means "mediocre" on a battlefield — until the engineers extend the barrel by thirty
    percent. Standard armor. Standard speed. But it reaches out further than the Harkonnen or Ordos
    variants. The water world of Caladan didn't breed brute force. It bred patience. Let the enemy
    charge. Then dismantle him before he enters firing range.
      Strong vs Tanks, Vehicles
      Weak vs Infantry
      Longer range than other Combat Tanks
      Armor: Heavy — resists bullets and explosives, vulnerable to missiles

combat-tank-h =
    .description =
    A slab of iron spat from the industrial furnaces of Giedi Prime. Heaviest. Slowest. Extra armor
    plating welded to the hatch. Engine limiter tuned down — the crew gets told that speed penalties
    don't apply as long as the engine still turns. Harkonnen doesn't retreat. Harkonnen pushes through.
      Strong vs Tanks, Vehicles
      Weak vs Infantry
      More HP, lower speed — less speed penalty on low HP
      Armor: Heavy — extremely durable, vulnerable to missiles

combat-tank-o =
    .description =
    Fastest. Lightest. Most dangerous — to itself and to the enemy. Ordos paid Ix to strip weight from
    the chassis, overclock the turret motor, and bump the fire rate. The cost is armor thin enough to
    worry about. Ordos doctrine never relied on the weight of a single blow. They wager this: in a long war of attrition, rate of fire will always outlast armor.
      Strong vs Tanks, Vehicles
      Weak vs Infantry
      Faster speed, lower HP — higher rate of fire
      Armor: Heavy — lightest of the three, vulnerable to missiles

bison-tank-desc =
    .description =
    Ixian-licensed heavy tank with twin barrels. Two shots. Reload. Two more. When the Quad isn't enough
    and the Devastator is too expensive, you buy the Bison. Devastating against armored columns and
    defensive structures.
      Strong vs Vehicles, Tanks, Defenses
      Weak vs Infantry
      Double-barrel — fires two shots per salvo
      Armor: Heavy — extremely durable, vulnerable to missiles

bombardment-tank-desc =
    .description =
    Another Ixian heavy engineering piece: a mobile battery that vomits a barrage of missiles. Four
    rockets gone in a salvo, then an agonizingly long reload. Wildly inaccurate. Painfully slow. But
    when all four missiles land on the same building complex at the same time, nothing is standing
    anymore.
      Strong vs Infantry, Buildings, Light Armor
      Weak vs Tanks, Moving Targets
      Special: 4-rocket salvo, then reload · High inaccuracy
      Armor: Light — vulnerable to missiles and cannons

scorch-tank-desc =
    .description =
    The perfect expression of Harkonnen military aesthetics: a giant flamethrower mounted on a tank
    chassis. Infantry? Ash. Buildings? Burning ruins. Spice fields? Set ablaze — along with any enemy
    harvester working them. Getting close triggers its fuel-tank explosion. Kill it from a distance.
    A very, very long distance.
      Strong vs Infantry, Buildings
      Weak vs Tanks, Defenses
      Special: Destroys Spice · Fuel tank explosion on death
      Armor: Light — vulnerable to missiles

## aircraft.yaml - Enhanced11 descriptions

carryall-manual =
    .description =
    An iron-winged beast, a war machine slung beneath its belly, twin wings slicing the scorching
    Arrakis thermals. When its shadow crosses the dunes, the soldiers below look up — and know their
    fate is suspended in the sky.
      Unarmed
      Special: Right-click to pick up vehicles · Deploy to drop · Ctrl/Alt to select
      Armor: Light — vulnerable to all anti-air fire

sonic-orni =
    .description =
    An Atreides "over-investment" in the standard Ornithopter airframe: strip the bomb rack, install
    a miniaturized sonic projector. It screams across the enemy line, sound beam raking both ground and
    air targets — enemy and ally alike, penetrating everything. Pilots who fly these always sit alone
    at the bar.
      Strong vs Infantry, Light Vehicles, Air
      Weak vs Moving Targets, Anti-air
      Special: Strafe attack · Beam hits friend and foe
      Armor: Light — vulnerable to anti-air fire

laser-orni =
    .description =
    The Ordos answer when sonic wasn't precise enough: they bought a laser retrofit kit from Ix. An
    instantaneous red beam. No trajectory to predict. No guidance to track. Point. Burn. Repeat. Ix has somehow stabilized the beam frequency so that it does not trigger catastrophic
    shield feedback — at least, not most of the time. Anti-air and anti-ground. Hover. Aim. Ignite.
      Strong vs Infantry, Light Vehicles, Air
      Weak vs Anti-air
      Special: Instant-hit laser · Can hover · Effective vs ground and air
      Armor: Light — vulnerable to anti-air fire

air-fortress =
    .description =
    House Harkonnen never truly understood flight. They understood weight. Firepower. And the kind of fear that
    leaves an enemy nowhere to run. So they put a Devastator into the sky. A massive hovering gunship cruising
    at cloud altitude — shock cannons on both flanks tear into the ground, a rapid-fire turret on top reaps
    the sky. Slow — so slow you forget it's moving — but when it slides above your base, the entire radar
    screen turns red.
      Strong vs Ground Vehicles, Tanks, Air
      Weak vs Massed anti-air
      Special: Three independent turrets (2 ground, 1 AA) · VTOL · 2 ammo, then reload · Unstable
      Armor: Light — massive HP pool, vulnerable to concentrated anti-air

## structures.yaml - Enhanced11 descriptions

conyard =
    .description =
    The first bone of a city. Within its furnace burn prefabricated beams and construction blueprints,
    spitting out building after building, laying roots of civilization across the rock. Kill it, and
    you've killed the whole war.

wind-trap =
    .description =
    Arrakis elegance: colossal surface scoops funnel desert thermals into underground turbine arrays,
    driving generators and humidity extractors in a single stroke. Power and water — elsewhere, two
    buildings. Here, one question of survival.

refinery =
    .description =
    The harvester returns full, docks, and pours raw spice down the crusher's throat. The Refinery
    turns sand into hard currency. One harvester included — delivered by the Guild, compliments of
    CHOAM.

refinery-inverted =
    .description =
    Same iron shell. Same crusher throat. The dock just opens from the north. When the standard Refinery
    faces the wrong way for your base layout, flip it.

barracks =
    .description =
    First lesson on Arrakis isn't the firing range. It's standing in the sun for three hours without
    collapsing from dehydration. Then come the guns.

light-factory =
    .description =
    Under a steel canopy, light-frame vehicles are bolted together from nothing by rivet guns and torque
    wrenches. It doesn't build heroes. It builds scouts. Not heavy enough. Not slow enough. Just fast
    enough.

outpost =
    .description =
    The first radar screen to light up on the sand. Once powered, the entire map resolves out of
    static — where the enemy base sits, where the worms are, where your doom is. Before, you were
    fighting blind. Now you can see.

heavy-factory =
    .description =
    Its steel frame warps in the desert heat, groaning with metal fatigue even at noon. The first sound
    of tracks crushing dunes comes from here. Then comes the cannon.

high-tech-factory =
    .description =
    Where grey Ixian patents walk into the sky. Maker of wings. What those wings drop — bombs, sound,
    or more steel — depends on who bought the shipment.

repair-pad =
    .description =
    An open-air workshop suspended under a magnetic crane arm. Drive the wrecked tank onto the pad.
    The crane descends. Rivet guns scream for fifteen seconds. It rolls off whole.

research-centre =
    .description =
    A fortress of knowledge walled in grey contracts and patent barriers. Every weapon blueprint that
    leaves here bears the Ixian seal — and a secrecy compact no House dares to break. Ix does not sell
    weapons — they sell exclusivity. And exclusivity, on Arrakis, costs more than spice.

starport-desc =
    .description =
    A CHOAM pricing clock. A Guild flight schedule. And a patch of land big enough for an interstellar
    freighter to set down. It doesn't build anything — it buys. Prices move with the market. Delivery
    speed depends on the Guild Navigator in orbit — and how much spice they have inhaled today. A good order
    saves ten minutes of tank production. CHOAM does not care who wins. Only that the order has been paid for.

wall =
    .description =
    Shells hit it and stop. Missiles don't.

silo =
    .description =
    Inside: spice. Nothing else.

gun-turret =
    .description =
    Concrete bunker. Auto-targeting. Armor-piercing rounds. Built-in cloak detector. Anything that walks
    within two cells is already locked before it fires its first shot.

rocket-turret =
    .description =
    A concrete head with four tubes. Wind blows through the barrels, the lowest whistle the desert knows.
    Only when that sound stops — something, somewhere, is falling.

palace-atreides =
    .description =
    Fremen footprints vanish into the deep desert. They walk out of a dust storm at the map's edge.
    They heard the summons before it was sent.

palace-harkonnen =
    .description =
    The Baron's will in steel, grimmer than any structure on Arrakis. A single Death Hand missile rests
    in the rooftop silo — an atomic cluster warhead splits above the target, and where it lands, only
    glass remains.

palace-ordos =
    .description =
    A commercial branch office of a frozen planet, condensed into a single dune structure. The Saboteur
    waits here — a walking bomb that needs only a name and a target.

palace-corrino =
    .description =
    The Empire has only a shadow here. But the shadow wears the black of Sardaukar. The Padishah Emperor may be far away on Kaitain — but his blade has never left Arrakis.

fremen-sietch =
    .description =
    Maker hooks hang at the entrance. Wind exhales from tunnel depths, carrying thousand-year-old
    prayers.

upgrade-conyard = Construction Yard Upgrade
    .description =
    Swaps the standard concrete formula for a denser, harder composite that withstands three times
    the grit erosion. All existing structures receive structural reinforcement.
    Unlocks:
      - Rocket Turret

upgrade-barracks = Barracks Upgrade
    .description =
    Heavier weapons. Thicker tactical manuals. And the names that only certain Houses are permitted
    to train.
    Unlocks:
      - Trooper
      - Engineer
      Faction-specific:
      - Thumper Infantry (Ordos)
      - Grenadier (Atreides)
      - Sardaukar (Harkonnen)

upgrade-light = Light Factory Upgrade
    .description =
    Fixed cannons come off. Rotating missile racks get welded on. The client with the grey contract
    clause received something extra.
    Unlocks:
      - Missile Quad
      - Dustrider
      Faction-specific:
      - Stealth Raider Trike (Ordos)

upgrade-heavy = Heavy Factory Upgrade
    .description =
    The sign outside replaces "Heavy Vehicles" with "War Machines".
    Unlocks:
      - Repair Pad
      - IX Research Center
      - Siege Tank
      - Missile Tank (Atreides, Harkonnen; Ordos via Starport)
      Faction-specific:
      - Deviator (Ordos)
      - Sonic Tank (Atreides)
      - Devastator (Harkonnen)

upgrade-starport =
    .description =
    The CHOAM sales representative turns one more page in the catalogue. It says "Contractors."
    Everything below it has a price tag.
    Unlocks:
      - Smugglers/Mercenaries reinforcements

upgrade-hightech = High Tech Factory Upgrade
    .description =
    Only two Houses are permitted through this door.
    Unlocks:
      - IX Research Center
      - Airstrike (Atreides)
      - Deviator Airstrike (Ordos)

atreides-airstrike = Atreides Airstrike
    .description =
    Ornithopters were never the first choice of House Atreides. War is the last resort of failed diplomacy. But when they appear — snake formation,
    wingtips skimming the dunes — you already lost the last round at the negotiating table.

ordos-airstrike = Ordos Airstrike
    .description =
    Deviator Ornithopters lift from the map edge, scatter, and hunt. They don't drop bombs — they drop
    a fog of allegiance. The crew that was shooting at you moments ago is now shooting at its own.

recruit-fremen = Recruit Fremen
    .description =
    The Fremen don't need orders. Their footprints haven't faded, and the desert has already delivered
    the message. Warriors and Sand Runners walk out of a dust storm at the map's edge. They heard the
    summons before it was sent.

death-hand = Death Hand
    .description =
    An atomic cluster warhead lifts from the Harkonnen Palace rooftop, splits above the target, and where
    it lands, only glass remains. The Great Convention forbids atomics. House Harkonnen's compliance is
    ensuring no one can prove they struck first.

recruit-saboteur = Recruit Saboteur
    .description =
    A walking bomb that needs only a name and a target. It vanishes into the horizon's heat-shimmer,
    and reappears at the enemy's doorstep.

rally-sardaukar-rally =
    .description =
    The horn sounds. Sardaukar abandon cover, stand upright, and begin their charge. No one has stopped
    them in a stand-up fight. Six centuries. No exceptions.

worm-rider-sp =
    .description =
    A Fremen Naib gets one chance in his lifetime to prove himself to the maker hooks. He anchors them
    into the sand. Shai-Hulud answers. He mounts the great beast, and the worm's shadow belongs to his
    tribe from that moment on.

## passthrough
absorbs-spice-obtained-by-the-wind-flow-provides-passive-income-equivalent-to-1-harvester = Absorbs Spice obtained by the wind flow. Provides Passive income equivalent to 1 harvester
atreides-combat-tank = Atreides Combat Tank
atreides-conyard = Atreides Conyard
atreides-palace = Atreides Palace
bison-tank = Bison tank
bison-tank-destroyed = Bison Tank (Destroyed)
bombardment-tank = Bombardment Tank
bombardment-tank-destroyed = Bombardment Tank (Destroyed)
bomber-ornithopter = Bomber Ornithopter
building-destroyed = Building (destroyed)
can-be-repaired-by-engineer = Can be repaired by engineer
carryall-husk = Carryall husk
carryall-husk-destroyed = Carryall (Destroyed)
deviator-ornithopter = Deviator Ornithopter
dummy-vehicle = dummy vehicle
dustrider-husk-destroyed = Dustrider Husk (Destroyed)
ecology-station = Ecology Station
emperor-palace = Emperor Palace
finalize-order-and-dispatch-choam-frigate = Finalize order and dispatch CHOAM frigate
fremen-temple = Fremen Temple
frigate-husk = Frigate husk
frigate-husk-destroyed = Frigate (Destroyed)
harkonnen-air-fortress = Harkonnen Air Fortress
harkonnen-combat-tank = Harkonnen Combat Tank
harkonnen-conyard = Harkonnen Conyard
harkonnen-palace = Harkonnen Palace
heal-nearby-infantry-units-if-captured-heals-all-players-infantry = Heal nearby infantry units. If captured heals all players infantry.
heavy-quad = Heavy Quad
laser-ornithopter = Laser Ornithopter
main-battle-tank = Main Battle Tank\n  Strong  vs Vehicles\n  Weak vs Infantry, Missiles \n Can crush Infantry
mcv-2x-carryall = MCV + 2x Carryall
mcv-carryall = MCV + Carryall
mining-rig = Mining rig
mining-rig-destroyed = Mining rig (Destroyed)
neutral-building = Neutral Building
no-room-for-new-unit = No room for new unit.
ordos-combat-tank = Ordos Combat Tank
ordos-conyard = Ordos Conyard
ordos-palace = Ordos Palace
ornithopter-husk-destroyed = Ornithopter (Destroyed)
provides-buildable-area-speed-up-building-production-by-10 = Provides buildable area. Speed up building production by 10%
provides-buildiable-area-provides-vision = Provides buildiable area, Provides vision
provides-small-passive-income-can-by-rebuild-when-destroyed = Provides small passive income. Can by rebuild when destroyed.
purchase-items = Purchase Items
purchase-vehicles-from-choam = Purchase vehicles from CHOAM
radar-station = Radar Station
radar-post = Radar Post
radar-post-desc = Detects invisible units at great range. Does not need energy.
rally-sardaukar = Rally Sardaukar
rally-sardaukars = Rally Sardaukars
reinforcements-waypoint = Reinforcements Waypoint
request-choam-delivery = Request CHOAM Delivery
sand-runner = Sand Runner
scorch-tank = Scorch Tank
scorch-tank-destroyed = Scorch Tank (Destroyed)
sonic-ornithopter = Sonic Ornithopter
spawn-worms = Spawn Worms
spawn-worms-options = Spawn worms options
spice-refinery-inverted = Spice Refinery Inverted
spice-sifter = Spice sifter
starport-upgrade = Starport upgrade
worm-rider = Worm Rider
Any = Any
Atreides = Atreides
Carryall = Carryall
carryall-support = Carryall A.I.
Conyard = Conyard
Crane = Crane
Dustrider = Dustrider
Gladius = Gladius
Harkonnen = Harkonnen
Ice = Ice
Never = Never
Omnius = Omnius
Ordos = Ordos
Ornithopter = Ornithopter
Palm = Palm
Sandworm = Sandworm
Sietch = Sietch
Spring = Spring
Vidious = Vidious
wpdummy = wpdummy
after-5-min = After 5 min
after-10-min = After 10 min
after-15-min = After 15 min
