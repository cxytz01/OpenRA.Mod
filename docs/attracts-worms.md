# AttractsWorms Intensity

## Current Status

`^Vehicle` and `^Tank` have `AttractsWorms` with pre-calculated per-unit Intensity values. `^Infantry` has **no** `AttractsWorms` — WormJaw cannot target infantry, causing the engine divide-by-zero crash when a worm chases infantry into the same cell.

### Base Templates (`defaults.yaml`)

```yaml
^Vehicle:
    AttractsWorms:
        Intensity: 30
        Falloff: 100, 95, 70, 42, 22, 10, 4, 1, 0

^Tank:
    AttractsWorms:
        Intensity: 70
        Falloff: 100, 95, 70, 42, 22, 10, 4, 1, 0
```

Per-unit Intensity overrides the base value where needed for correct ranking.

---

## Formula

```
Intensity = round(HP ÷ 500 × ArmorMultiplier + EffectiveCost ÷ 2) + Int加值
```

- **EffectiveCost** = 有 cost 则用 cost，无 cost 则用 **替代cost** 列的值
- **Int加值** = 手动修正值

### Armor Multiplier

| Armor | Multiplier |
|-------|:----------:|
| none  | ×0.3       |
| wood  | ×1.4       |
| light | ×1.6       |
| heavy | ×2.0       |

> **Cloak is not factored into the formula.** Sandworms track targets by ground vibration, not vision. A cloaked unit produces the same seismic noise as an uncloaked one of equal mass.

### Falloff

| Step | Range (cells) | % |
|:----:|:---:|:---:|
| 0 | 0 | 100 |
| 1 | 3 | 95 |
| 2 | 6 | 70 |
| 3 | 9 | 42 |
| 4 | 12 | 22 |
| 5 | 15 | 10 |
| 6 | 18 | 4 |
| 7 | 21 | 1 |
| 8 | 24 | 0 |

> `Spread: 3072` (3 cells per step, engine default).

---

## Infantry — none×0.3 *(not implemented — causes crash)*

> **⚠ WormJaw has `InvalidTargets: Infantry`. If infantry has `AttractsWorms`, worms chase them but cannot attack in Phase 1 (3-cell range). Sandworm falls through to noise aggregation → reaches the infantry cell → `AttractionAtPosition` divides by zero (length=0). These values are kept for reference when the engine bug is fixed.**

| Rank | Unit | HP | cost | 替代cost | Int加值 | Calc | Int |
|:----:|------|-------|:---:|:--------:|:------:|------|:---:|
| 1 | worm_rider | 14000 | — | 500 | | 14000÷500×0.3 + 500÷2 | **258** |
| 2 | saboteur | 9700 | — | 300 | | 9700÷500×0.3 + 300÷2 | **156** |
| 3 | sardaukar | 10000 | 200 | — | | 10000÷500×0.3 + 200÷2 | **106** |
| 4 | thumper | 12750 | 500 | — | -150 | 12750÷500×0.3 + 500÷2 - 150 | **108** |
| 5 | fremen | 7000 | — | 150 | | 7000÷500×0.3 + 150÷2 | **79** |
| 6 | engineer | 5000 | 400 | — | -130 | 5000÷500×0.3 + 400÷2 - 130 | **73** |
| 7 | trooper | 7000 | 100 | — | | 7000÷500×0.3 + 100÷2 | **54** |
| 8 | grenadier | 6000 | 80 | — | | 6000÷500×0.3 + 80÷2 | **44** |
| 9 | light_inf | 6000 | 50 | — | | 6000÷500×0.3 + 50÷2 | **29** |

## Vehicle

| Rank | Unit | HP | Armor | cost | 替代cost | Int加值 | Calc | Int |
|:----:|------|-------|:--:|:---:|:--------:|:------:|------|:---:|
| 1 | dustrider | 14000 | heavy | 500 | — | | 14000÷500×2.0 + 500÷2 | **327** |
| 2 | heavy_quad | 12700 | light | 450 | — | | 12700÷500×1.6 + 450÷2 | **266** |
| 3 | quad | 11000 | light | 400 | — | | 11000÷500×1.6 + 400÷2 | **235** |
| 4 | sand_runner | 9000 | light | 400 | — | | 9000÷500×1.6 + 400÷2 | **229** |
| 5 | stealth_raider | 10000 | wood | 400 | — | | 10000÷500×1.4 + 400÷2 | **228** |
| 6 | raider | 9500 | wood | 350 | — | | 9500÷500×1.4 + 350÷2 | **202** |
| 7 | trike | 9000 | wood | 300 | — | | 9000÷500×1.4 + 300÷2 | **175** |

## Tank

| Rank | Unit | HP | Armor | cost | 替代cost | Int加值 | Calc | Int |
|:----:|------|-------|:--:|:---:|:--------:|:------:|------|:---:|
| 1 | mcv | 53000 | light | 2000 | — | | 53000÷500×1.6 + 2000÷2 | **1170** |
| 2 | devastator | 60000 | heavy | 1200 | — | | 60000÷500×2.0 + 1200÷2 | **840** |
| 3 | harvester | 45000 | light | 1200 | — | | 45000÷500×1.6 + 1200÷2 | **744** |
| 4 | sonic_tank | 28000 | light | 1100 | — | | 28000÷500×1.6 + 1100÷2 | **640** |
| 5 | bombardment_tank | 27000 | light | 1050 | — | | 27000÷500×1.6 + 1050÷2 | **611** |
| 6 | deviator | 11000 | light | 1000 | — | 70 | 11000÷500×1.6 + 1000÷2 + 70 | **605** |
| 7 | bison_tank | 31000 | heavy | 950 | — | | 31000÷500×2.0 + 950÷2 | **599** |
| 8 | flamer | 25000 | light | 1000 | — | | 25000÷500×1.6 + 1000÷2 | **580** |
| 9 | missile_tank | 13000 | wood | 900 | — | | 13000÷500×1.4 + 900÷2 | **486** |
| 10 | combat_tank_h | 29000 | heavy | 700 | — | | 29000÷500×2.0 + 700÷2 | **466** |
| 11 | combat_tank_a | 22000 | heavy | 700 | — | | 22000÷500×2.0 + 700÷2 | **438** |
| 12 | combat_tank_o | 19000 | heavy | 700 | — | | 19000÷500×2.0 + 700÷2 | **426** |
| 13 | siege_tank | 12000 | light | 750 | — | | 12000÷500×1.6 + 750÷2 | **413** |

## Excluded

| Unit | Reason |
|------|--------|
| All infantry | Not implemented — WormJaw cannot target Infantry |
| mp_sandworm | 沙虫本身 |
| sardaukar.level1~3 | Inherits sardaukar |
| mpsardaukar | 不出现在游戏中 |
| probe.reachability | 探路用途 |
| fremen.spawn | Inherits fremen |
