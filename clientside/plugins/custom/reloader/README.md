# WotLK > Plugin > Custom > Reloader

## Features
- reload all plugins
- plugins can detect reloading state by `AMSTREPLUG_IN_PROGRESS` global variable

## Installation
- download [00_reloader.lua](https://raw.githubusercontent.com/AmsTaFFix/gmr-stuff/main/clientside/plugins/custom/00_reloader.lua)
- place downloaded file `00_reloader.lua` into
  - HWT: `{HWT_Dir}/addons/Wrath of the Lichking/Plugins/`
  - Tinkr: `{Tinkr_Dir}/scripts/GMR/Plugins/`

## Usage
- type in WoW's chat `/amstreplug`

## WARNING
It is very simple script that just reread all file in `Plugins/` directory, so it can't help if plugin can't work 
properly after reload, you should change the plugins instead, example in [amstlib.lua](https://raw.githubusercontent.com/AmsTaFFix/gmr-stuff/main/backside/plugins/custom/00_amstlib.lua)

## Donation
I will be very grateful for a cup of coffee :)

### My Wallets (Preferred way)
- **BTC** - 1FL5Cw8bjG7UDbLBAkayXv8j8nAWXys897
- **LTC** - ltc1ql9lzdv070qdzwu4hgwz4xj5wy0sx4uyz7uek0y
- **USDT TRC20** - TSMDyHz95MBpjECvfphDGoNYpDZeu4B8cd
 
### Links to aggregates
- [Coinbase](https://commerce.coinbase.com/checkout/4662ac44-ca8c-4f8f-9130-d647d0d89da0)
- [NOWPayments](https://nowpayments.io/donation/AmsTaFFix)