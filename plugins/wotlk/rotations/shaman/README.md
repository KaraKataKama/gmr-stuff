# Paladin Rotation
## Features
- uses lightnight bolt, lavaburst, totemOfWrath, flame shock
- Self-healing based on Health% condition
- keeps waterShield up
- online update

## Installation
- turn off spells in Spells tab:
  - Water Shield
  - Lightning Bolt
  - Healing Wave
  - Lesser Healing Wave
  - Flame Shock

- drop `01_darakan_shaman_elemental.lua` into 
  - HWT: `{HWT_Dir}/addons/Wrath of the Lichking/Plugins/`
  - Tinkr: `{Tinkr_Dir}/scripts/GMR/Plugins/`
## Backlog
- Add Earth Shock
- Add Totem Logic
- AOE Rotation (Chain Lightning etc.)
- Poison/Disease Removal
- Weapon Buff (Flametongue)
## Tuning
File `01_darakan_shaman_elemental.lua` has Config lua table with some tune options, you can change as you like
## Troubleshooting
If you encounter problems you should:
- turn on debug mode (just change `Config.debug` from `false` to `true`), then `/reload`.
- record a video
- send it to discord **Darakan#4124**
