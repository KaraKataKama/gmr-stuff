# WotLK > Plugin > Combat Rotation > Death Knight > Blood

## Features
- trying his best to execute proper rotation according to [this guide](https://www.wowhead.com/wotlk/guides/blood-death-knight-tank-overview-best-races-professions)
- tested with [this build](https://www.wowhead.com/wotlk/talent-calc/death-knight/23050005-32005350352203012300033101351_001s8q11s9f21xv631ts841sxd51s8g)
- online updates
- open source

## Installation
- delete previous versions!
- turn off all spells in Spells tab
- download [01_amstaffix_deathknight_blood_loader.lua](https://raw.githubusercontent.com/AmsTaFFix/gmr-stuff/main/clientside/plugins/rotations/deathkight/blood/v4/01_amstaffix_deathknight_blood_loader.lua)
- place downloaded file `01_amstaffix_deathknight_blood_loader.lua` into
  - HWT: `{HWT_Dir}/addons/Wrath of the Lichking/Plugins/`
  - Tinkr: `{Tinkr_Dir}/scripts/GMR/Plugins/`

## Tuning
File has Config lua table with some tune options, you can change as you like

## Backlog
- make cast interrupts smarter
- make more tests with death pact + ghoul combo
- make proper actions to make summoned ghoul more powerful
- find a way to use antimagic shield (or what the proper name)
- add auto cast to ally ressurection

## Troubleshooting
If you encounter problems you should:
- turn on debug mode (just change `debug = false` to `debug = true` in downloaded file), then type `/reload` in WoW client.
- do not hide chat window
- record a video (from start of client till encountered issue)
- DM to **AmsTaFFix#0047** with
  - Unlocker type (HWT, Tinkr, Magick)
  - Description of issue
  - Video as attachment/link
  - Downloaded plugin as attachment
  - Screenshot of your `Plugins/` directory

## Donation
I will be very grateful for a cup of coffee :)

### Links to aggregates
- [Coinbase](https://commerce.coinbase.com/checkout/4662ac44-ca8c-4f8f-9130-d647d0d89da0)
- [NOWPayments](https://nowpayments.io/donation/AmsTaFFix)

### My Wallets
- **BTC** - bc1ql730vv096l5se535hllsst6367d3j27n5e0a7x
- **LTC** - ltc1qgt8asz8wn5t8erjqdm4zhsde5h4vrzwmz648zx
- **USDT TRC20** - TN9BKkVK1Nv7g67rSCNQLyf4uQZyEwZUcE