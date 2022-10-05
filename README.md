# WotLK GMR Plugins&Profiles
This repository holds plugins (mostly combat rotations), profiles for WotLK

## Info for Clients
Please follow to the `clientside/` directory and choose plugins/profiles. Every work has its own `README.md` file, 
please read it before start using plugin/profile.

## Donation
I will be very grateful for a cup of coffee :)
### Links to aggregates
- [Coinbase](https://commerce.coinbase.com/checkout/4662ac44-ca8c-4f8f-9130-d647d0d89da0)
- [NOWPayments](https://nowpayments.io/donation/AmsTaFFix)
### My Wallets
- **BTC** - bc1ql730vv096l5se535hllsst6367d3j27n5e0a7x
- **LTC** - ltc1qgt8asz8wn5t8erjqdm4zhsde5h4vrzwmz648zx
- **USDT TRC20** - TN9BKkVK1Nv7g67rSCNQLyf4uQZyEwZUcE

## Info for Developers
### Main parts of repository
This repo has two main parts: `clientside/` and `backside/`. 

In `clientside/` you should place these:
- `*.lua files` that client should download and place it in their GMR's Plugins/Profiles folder
- `README.md` file, that describes details of your product. Mandatory sections are: `Installation` and `Troubleshooting`

In `backside/` you should place files, that client should not see, like:
- online downloadable parts of your plugins/profiles
- utility files/executables etc.
- api definitions

### Cookbook
#### How to make a combat rotation
1. create directory for clients `clientside/plugins/rotations/{classname}/{specname}/`
2. in that directory create files:
   - `01_{author}_{classname}_{space_name}_loader.lua`
   - `README.md`
3. create directory for developers `backside/plugins/rotations/{classname}/{specname}/`
4. in developer's dir create these files:
   - `01_{author}_{classname}_{space_name}_rotation.lua`
   - maybe some other files, that you will need

### Q&A
#### Why files always has prefix in numbers (`00`, `01`, `02`, etc)
Short answer is - for convenient offline testing.

GMR load plugins one by one in alphabeting order, so if we want to ensure load order, we should use safe way to 
determine that order. That's why.

#### Why I, as a developer, can't place all files into `clientside/` dir?
Because not all clients read carefully `Installation` section of `README.md` and they download every file in plugin 
folder, that always encounter issues

### Common `README.md` parts
#### Combat rotation `Installation` section
- you should replace `FILE_NAME` and `LINK_TO_YOUR_FILE` to your own 
```
## Installation
- delete previous versions!
- {your own instruction to do something, like turn off specific spells in Spells tab etc}
- download [{FILE_NAME}]({LINK_TO_YOUR_FILE})
- place downloaded file `{FILE_NAME}` into
  - HWT: `{HWT_Dir}/addons/Wrath of the Lichking/Plugins/`
  - Tinkr: `{Tinkr_Dir}/scripts/GMR/Plugins/`
```
#### Combat rotation `Troubleshooting`
- you should replace `YOUR_DISCORD_ID` to your own
```
## Troubleshooting
If you encounter problems you should:
- turn on debug mode (just change `debug = false` to `debug = true` in downloaded file), then type `/reload` in WoW client.
- do not hide chat window
- record a video (from start of client till encountered issue)
- DM to **{YOUR_DISCORD_ID}** with
   - Unlocker type (HWT, Tinkr, Magic)
   - Description of issue
   - Video as attachment/link
   - Downloaded plugin as attachment
   - Screenshot of your `Plugins/` directory
```
