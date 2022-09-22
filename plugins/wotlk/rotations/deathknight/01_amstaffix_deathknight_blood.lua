AMST_SHARE = AMST_SHARE or {}

---@type DeathKnightBloodConfig
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = false,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = true,
    ---Use online loading feature to get last updates
    onlineLoad = true,
    ---Min HP to cast Rune Tap, if known
    runeTapHpUse = 80,
    ---Min HP to cast Vampiric Blood
    vampiricBloodHpUse = 70,
    ---Min HP to cast Icebound Fortitude
    iceboundFortitudeHpUse = 50,
    bloodBoilEnabled = true,
    ---Should bot use only blood runes for blood-runes offensive spells like Blood Boil, Heart/Blood Strike
    useBloodFillersWithBloodRunesOnly = true,
    ---Min enemies to start using Blood Boil instead off Blood/Hearth Strike
    bloodBoilMinEnemies = 3,
    ---Default presence
    --- - 1:blood;
    --- - 2:frost;
    --- - 3:unholy;
    defaultPresence = 1,
    ---Change presence on frost, if HP < X. Change it to 0 to turn off
    minHpToChangeToFrostPresence = 60,
    ---Min enemies to cast raise dead spell
    minEnemiesCountToRaiseDead = 2,

    ---Should use Rune Strike
    useRuneStrike = true,
    ---Delay between Rune Strike usage. If you encounter some issues with rune strike, tune this option.
    useRuneStrikeDelay = 0.5,
    ---Min HP to start using Death Strike more often
    minHPToUseDeathStrikeMoreOften = 90,
    minHPToUseDeathPact = 80,
    useStrangulateToInterruptCasts = true,
    useDeathGripToInterruptCasts = true,

    useUnholyFrenzyOnSelf = true,
    useUnholyFrenzyMinEnemies = 3,

    useDeathAndDecay = false,
    useDeathAndDecayMinEnemies = 3,

    useDancingRuneWeaponMinEnemies = 3,

    useMarkOfBloodMinEnemies = 3,
    useMarkOfBloodMinHP = 70,

    useDeathCoilOnEnemy = true,
    useDeathCoilOnEnemyMaxEnemies = 1,

    useCorpseExplosion = true,
    useCorpseExplosionMinEnemies = 3,
}

AMST_SHARE["CR/DK/B.CFG"] = Config
if Config.onlineLoad then
    local httpRequester = _G.SendHttpRequestTinkrFix or GMR.SendHttpRequest
    httpRequester({
        Url = "https://raw.githubusercontent.com/AmsTaFFix/gmr-stuff/main/plugins/wotlk/rotations/deathknight/02_amstaffix_deathknight_blood_rotation.lua",
        Method = "Get",
        Callback = function(content)
            GMR.RunString(content)
            if AMST_SHARE["CR/DK/B.LOADED"] ~= true then
                GMR.Print("[CR>DK/B][ERROR] Rotation have not loaded properly!")
            end
        end
    })
else
    GMR.Print("[CR>DK/B] Offline loading turned on")
end
