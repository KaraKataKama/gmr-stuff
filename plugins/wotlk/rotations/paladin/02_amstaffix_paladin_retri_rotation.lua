--This file is part of the AmsTaFFix' GMR plugins/profiles distribution
--(https://github.com/AmsTaFFix/gmr-stuff).
--Copyright (C) 2022 Nikita Sapogov
--
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU General Public License
--along with this program.  If not, see <https://www.gnu.org/licenses/>.

AMST_SHARE = AMST_SHARE or {}
AMST_SHARE["CR>P/R.LOADED"] = true
local VERSION = "v1.6.0"
local printMsgPrefix = "[CR>P/R|" .. VERSION .. "] "

---Print message with CR prefix
---@param msg string
local function Print(msg)
    GMR.Print(printMsgPrefix .. msg)
end

local function Error(msg)
    Print(printMsgPrefix .. "[ERROR]  " .. msg)
end

local CLASS_WARRIOR = "WARRIOR"
local CLASS_PALADIN = "PALADIN"
local CLASS_HUNTER = "HUNTER"
local CLASS_ROGUE = "ROGUE"
local CLASS_PRIEST = "PRIEST"
local CLASS_DEATHKNIGHT = "DEATHKNIGHT"
local CLASS_SHAMAN = "SHAMAN"
local CLASS_MAGE = "MAGE"
local CLASS_WARLOCK = "WARLOCK"
local CLASS_MONK = "MONK"
local CLASS_DRUID = "DRUID"
local CLASS_DEMONHUNTER = "DEMONHUNTER"
local CLASS_EVOKER = "EVOKER"

local spells = {
    exorcism = GetSpellInfo(5614),
    flashOfLight = GetSpellInfo(19939),
    hammerOfWrath = GetSpellInfo(24275),
    handOfReckoning = GetSpellInfo(62124),
    purify = GetSpellInfo(1152),
    cleanse = GetSpellInfo(4987),
    crusaderStrike = GetSpellInfo(35395),
    consecrations = GetSpellInfo(20116),
    divineStorm = GetSpellInfo(53385),
    judgementOfLight = GetSpellInfo(20271),
    judgementOfWisdom = GetSpellInfo(53408),
    judgementOfJustice = GetSpellInfo(53407),
    devotionAura = GetSpellInfo(10293),
    retributionAura = GetSpellInfo(10301),
    concentrationAura = GetSpellInfo(19746),
    crusaderAura = GetSpellInfo(32223),
    blessingOfFreedom = GetSpellInfo(1044),
    blessingOfMight = GetSpellInfo(19837),
    blessingOfKings = GetSpellInfo(20217),
    blessingOfWisdom = GetSpellInfo(27142),
    sealOfRighteousness = GetSpellInfo(21084),
    sealOfJustice = GetSpellInfo(20164),
    sealOfLight = GetSpellInfo(20165),
    sealOfWisdom = GetSpellInfo(20166),
    sealOfCommand = GetSpellInfo(20375),
    sealOfCorruption = GetSpellInfo(348704),
    greaterBlessingOfMight = GetSpellInfo(25916),
    greaterBlessingOfKings = GetSpellInfo(25898),
    shadowResistanceAura = GetSpellInfo(27151),
    frostResistanceAura = GetSpellInfo(19898),
    divineProtection = GetSpellInfo(498),
    handOfProtection = GetSpellInfo(5599),
    fireResistanceAura = GetSpellInfo(27153),
    holyLight = GetSpellInfo(25292),
    flashOfLight = GetSpellInfo(19943),
    holyShock = GetSpellInfo(33072),
}

local spellKnown = {
    exorcism = GMR.IsSpellKnown(spells.exorcism),
    flashOfLight = GMR.IsSpellKnown(spells.flashOfLight),
    hammerOfWrath = GMR.IsSpellKnown(spells.hammerOfWrath),
    handOfReckoning = GMR.IsSpellKnown(spells.handOfReckoning),
    purify = GMR.IsSpellKnown(spells.purify),
    cleanse = GMR.IsSpellKnown(spells.cleanse),
    crusaderStrike = GMR.IsSpellKnown(spells.crusaderStrike),
    consecrations = GMR.IsSpellKnown(spells.consecrations),
    divineStorm = GMR.IsSpellKnown(spells.divineStorm),
    judgementOfLight = GMR.IsSpellKnown(spells.judgementOfLight),
    judgementOfWisdom = GMR.IsSpellKnown(spells.judgementOfWisdom),
    judgementOfJustice = GMR.IsSpellKnown(spells.judgementOfJustice),
    devotionAura = GMR.IsSpellKnown(spells.devotionAura),
    retributionAura = GMR.IsSpellKnown(spells.retributionAura),
    concentrationAura = GMR.IsSpellKnown(spells.concentrationAura),
    crusaderAura = GMR.IsSpellKnown(spells.crusaderAura),
    blessingOfFreedom = GMR.IsSpellKnown(spells.blessingOfFreedom),
    blessingOfMight = GMR.IsSpellKnown(spells.blessingOfMight),
    blessingOfKings = GMR.IsSpellKnown(spells.blessingOfKings),
    blessingOfWisdom = GMR.IsSpellKnown(spells.blessingOfWisdom),
    sealOfRighteousness = GMR.IsSpellKnown(spells.sealOfRighteousness),
    sealOfJustice = GMR.IsSpellKnown(spells.sealOfJustice),
    sealOfLight = GMR.IsSpellKnown(spells.sealOfLight),
    sealOfWisdom = GMR.IsSpellKnown(spells.sealOfWisdom),
    sealOfCommand = GMR.IsSpellKnown(spells.sealOfCommand),
    greaterBlessingOfMight = GMR.IsSpellKnown(spells.greaterBlessingOfMight),
    greaterBlessingOfKings = GMR.IsSpellKnown(spells.greaterBlessingOfKings),
    shadowResistanceAura = GMR.IsSpellKnown(spells.shadowResistanceAura),
    frostResistanceAura = GMR.IsSpellKnown(spells.frostResistanceAura),
    divineProtection = GMR.IsSpellKnown(spells.divineProtection),
    handOfProtection = GMR.IsSpellKnown(spells.handOfProtection),
    fireResistanceAura = GMR.IsSpellKnown(spells.fireResistanceAura),
    sealOfCorruption = GMR.IsSpellKnown(spells.sealOfCorruption),
    holyLight = GMR.IsSpellKnown(spells.holyLight),
    flashOfLight = GMR.IsSpellKnown(spells.flashOfLight),
    holyShock = GMR.IsSpellKnown(spells.holyShock),
}

local buffs = {
    theArtOfWar = GetSpellInfo(59578),
    blessingOfMight = GetSpellInfo(19837),
    blessingOfKings = GetSpellInfo(20217),
    sealOfRighteousness = GetSpellInfo(21084),
    sealOfJustice = GetSpellInfo(20164),
    sealOfLight = GetSpellInfo(20165),
    sealOfWisdom = GetSpellInfo(20166),
    sealOfCommand = GetSpellInfo(20375),
    sealOfCorruption = GetSpellInfo(348704),
    greaterBlessingOfMight = GetSpellInfo(25916),
    greaterBlessingOfKings = GetSpellInfo(25898),
    battleShout = GetSpellInfo(2048),
    devotionAura = GetSpellInfo(10293),
    retributionAura = GetSpellInfo(10301),
    concentrationAura = GetSpellInfo(19746),
    crusaderAura = GetSpellInfo(32223),
    shadowResistanceAura = GetSpellInfo(27151),
    frostResistanceAura = GetSpellInfo(19898),
    fireResistanceAura = GetSpellInfo(27153),
    infusionOfLight = GetSpellInfo(54149),
    blessingOfWisdom = GetSpellInfo(27142),
}

local buffSameClassLists = {
    { buffs.greaterBlessingOfMight, buffs.blessingOfMight, buffs.battleShout },
    { buffs.greaterBlessingOfKings, buffs.blessingOfKings },
}

local debuffs = {
    hammerOfJustice = GetSpellInfo(10308),
    wintersChill = GetSpellInfo(12579),
    improvedScorch = GetSpellInfo(22959),
    livingBomb = GetSpellInfo(44457),
    corruption = GetSpellInfo(27216),
    ignite = GetSpellInfo(12654),
    frostFever = GetSpellInfo(55095),
    frostbite = GetSpellInfo(12494),
    righteousVengeance = GetSpellInfo(61840),
    chainsOfIce = GetSpellInfo(45524),
    seedOfCorruption = GetSpellInfo(27243),
    strangulate = GetSpellInfo(47476),
    infectedWounds = GetSpellInfo(58181),
    coneOfCold = GetSpellInfo(27087),
    flameShock = GetSpellInfo(25457),
    moonfire = GetSpellInfo(26988),
    holyVengeance = GetSpellInfo(31803),
    thunderclap = GetSpellInfo(15588),
    woundPoison5 = GetSpellInfo(27189),
    shatteredBarrier = GetSpellInfo(55080),
    judgementOfLight = GetSpellInfo(20185),
    shadowWordPain = GetSpellInfo(25367),
    silencedShieldOfTheTemplar = GetSpellInfo(63529),
    psychicScream = GetSpellInfo(10890),
    bloodPlague = GetSpellInfo(55078),
    huntersMark = GetSpellInfo(14325),
    vampiricTouch = GetSpellInfo(34917),
    frostNova = GetSpellInfo(27088),
    judgementOfJustice = GetSpellInfo(20184),
    vindication = GetSpellInfo(26017),
    chilled = GetSpellInfo(7321),
    devouringPlague = GetSpellInfo(25467),
    insectSwarm = GetSpellInfo(27013),
    repentance = GetSpellInfo(20066),
    frostbolt = GetSpellInfo(38697),
    serpentSting = GetSpellInfo(27016),
    earthAndMoon = GetSpellInfo(60433),
    shadowfury = GetSpellInfo(30414),
    immolate = GetSpellInfo(27215),
    viperSting = GetSpellInfo(3034),
    unstableAffliction = GetSpellInfo(31117),
    haunt = GetSpellInfo(59161),
    ebonPlague = GetSpellInfo(51735),
    deathCoil = GetSpellInfo(27223),
    judgementOfWisdom = GetSpellInfo(20186),
    deadlyPoison = GetSpellInfo(34655),
    silencingShot = GetSpellInfo(34490),
    psychicHorror = GetSpellInfo(64044),
    deadlyPoison7 = GetSpellInfo(27187),
    avengersShield = GetSpellInfo(32700),
    mindTrauma = GetSpellInfo(48301),
    shadowMastery = GetSpellInfo(17800),
    shadowEmbrace = GetSpellInfo(32391),
    earthbind = GetSpellInfo(3600),
    dragonsBreath = GetSpellInfo(33043),
    cripplingPoison = GetSpellInfo(3409),
    spellLock = GetSpellInfo(24259),
    faerieFire = GetSpellInfo(770),
    envelopingWeb = GetSpellInfo(15471),
    aftermath = GetSpellInfo(18118),
    entrapment = GetSpellInfo(19185),
    cryptFever = GetSpellInfo(50509),
    blackArrow = GetSpellInfo(63670),
    faerieFireFeral = GetSpellInfo(16857),
    forbearance = GetSpellInfo(25771),
    freezingTrapEffect = GetSpellInfo(14309),
    markOfBlood = GetSpellInfo(49005),
    freeze = GetSpellInfo(33395),
}

local debuffIndex = {}
for _, v in pairs(debuffs) do
    debuffIndex[v] = true
end

local debuffsLowPriority = {
    debuffs.wintersChill,
    debuffs.improvedScorch,
    debuffs.corruption,
    debuffs.ignite,
    debuffs.righteousVengeance,
    debuffs.flameShock,
    debuffs.moonfire,
    debuffs.holyVengeance,
    debuffs.judgementOfLight,
    debuffs.shadowWordPain,
    debuffs.bloodPlague,
    debuffs.chilled,
    debuffs.serpentSting,
    debuffs.judgementOfWisdom,
    debuffs.deadlyPoison,
    debuffs.deadlyPoison7,
    debuffs.shadowMastery,
    debuffs.ebonPlague,
    debuffs.frostFever,
    debuffs.huntersMark,
    debuffs.faerieFire,
    debuffs.vindication,
    debuffs.frostbolt,
    debuffs.cryptFever,
    debuffs.blackArrow,
    debuffs.faerieFireFeral,
}

local debuffNotRecommendDispelList = {
    debuffs.livingBomb,
    debuffs.vampiricTouch
}

local debuffNeverDispelList = {
    debuffs.unstableAffliction,
}

local debuffTopPriorityList = {
    debuffs.frostbite,
    debuffs.chainsOfIce,
    debuffs.hammerOfJustice,
    debuffs.strangulate,
    debuffs.thunderclap,
    debuffs.woundPoison5,
    debuffs.shatteredBarrier,
    debuffs.silencedShieldOfTheTemplar,
    debuffs.psychicScream,
    debuffs.frostNova,
    debuffs.judgementOfJustice,
    debuffs.repentance,
    debuffs.shadowfury,
    debuffs.viperSting,
    debuffs.haunt,
    debuffs.deathCoil,
    debuffs.silencingShot,
    debuffs.psychicHorror,
    debuffs.spellLock,
    debuffs.freezingTrapEffect,
    debuffs.markOfBlood,
    debuffs.freeze,
}

local debuffCleanseClassWhiteList = {
    [debuffs.huntersMark] = { CLASS_DRUID, CLASS_ROGUE },
    [debuffs.faerieFire] = { CLASS_DRUID, CLASS_ROGUE },
    [debuffs.faerieFireFeral] = { CLASS_DRUID, CLASS_ROGUE },
    [debuffs.frostFever] = { CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATHKNIGHT, CLASS_SHAMAN, CLASS_MONK, CLASS_DRUID, CLASS_DEMONHUNTER },
    [debuffs.vindication] = { CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATHKNIGHT, CLASS_SHAMAN, CLASS_MONK, CLASS_DRUID, CLASS_DEMONHUNTER }, -- melee only
    [debuffs.frostbolt] = { CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATHKNIGHT, CLASS_SHAMAN, CLASS_MONK, CLASS_DRUID, CLASS_DEMONHUNTER },
    [debuffs.chilled] = { CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATHKNIGHT, CLASS_SHAMAN, CLASS_MONK, CLASS_DRUID, CLASS_DEMONHUNTER },
}

local debuffCustomLogicList = {
    debuffs.livingBomb,
}

local debuffBlessingOfFreedomList = {
    debuffs.envelopingWeb,
}

local glyphSpells = {
}

---@class PaladinConfig
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = false,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = false,
    ---Use online loading feature to get last updates
    onlineLoad = true,
    consumeArtOfWarFlashLightMinHp = 80,
    consumeArtOfWarFlashLightIfAuraDepletedSoon = true,

    useConsecrations = true,
    useConsecrationsMinEnemies = 2,
    useDivineStormMinEnemies = 2,

    groupCleanseModEnabled = false,
    useJudgmentType = 1, -- 1:Judgement of Light; 2:Judgement of Wisdom; 3:Judgement of Justice;
    useJudgmentTryToCleave = true,
    useJudgmentForDebuffOnly = false,
    useJudgmentCooldown = 10,

    useHandOfReckoningToMakeDamage = true,
    useHandOfReckoningInInstance = false,

    defaultAuraToUse = 2, -- 1:Devotion Aura; 2:Retribution Aura; 3:Concentration Aura; 4:Shadow Resistance Aura; 5:Frost Resistance Aura; 6:Fire Resistance Aura
    defaultAuraChangeIfAlreadyExist = { 1, 3 }, -- 1:Devotion Aura; 2:Retribution Aura; 3:Concentration Aura; 4:Shadow Resistance Aura; 5:Frost Resistance Aura; 6:Fire Resistance Aura
    defaultBlessingToUse = 1, -- 1:Blessing of Might; 2:Blessing of Kings; 3:Blessing of Wisdom
    defaultSealToUse = 1, -- 1:Seal of Righteousness; 2:Seal of Justice; 3:Seal of Light; 4:Seal of Wisdom; 5:Seal of Command; 6:Seal of Corruption;
    defaultSealDoNotSwitchList = { 6 }, -- 1:Seal of Righteousness; 2:Seal of Justice; 3:Seal of Light; 4:Seal of Wisdom; 5:Seal of Command; 6:Seal of Corruption;

    useCrusaderAuraWhileMounted = true,
    useCrusaderAuraWhileMounterMinDistance = 50,

    useBlessingOfFreedom = true,

    groupBuffModEnabled = false,
    groupBuffModMinMana = 70,

    useDivineProtectionMinHP = 70,
    useHandOfProtectionMinHP = 40,

    healModEnabled = false,
    healModHolyLightHealAmount = 3200,
    healModFlashOfLightHealAmount = 820,
    healModHolyShockHealAmount = 1800,
}

---@class PaladinAuraSettings
local AuraSettings = {
    cfgIndex = 0,
    spell = "",
    spellKnown = "",
    buff = "",
}

---@return PaladinAuraSettings
function AuraSettings:new(cfgIndex, spell, spellKnown, buff)
    local o = {
        cfgIndex = cfgIndex,
        spell = spell,
        spellKnown = spellKnown,
        buff = buff,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@type table<number, PaladinAuraSettings>
local cfgIndexToAuraSettingsMap = {
    [1] = AuraSettings:new(1, spells.devotionAura, spellKnown.devotionAura, buffs.devotionAura),
    [2] = AuraSettings:new(2, spells.retributionAura, spellKnown.retributionAura, buffs.retributionAura),
    [3] = AuraSettings:new(3, spells.concentrationAura, spellKnown.concentrationAura, buffs.concentrationAura),
    [4] = AuraSettings:new(4, spells.shadowResistanceAura, spellKnown.shadowResistanceAura, buffs.shadowResistanceAura),
    [5] = AuraSettings:new(5, spells.frostResistanceAura, spellKnown.frostResistanceAura, buffs.frostResistanceAura),
    [6] = AuraSettings:new(6, spells.fireResistanceAura, spellKnown.fireResistanceAura, buffs.fireResistanceAura)
}

---@class PaladinSealSettings
local PaladinSealSettings = {
    cfgIndex = 0,
    spell = "",
    spellKnown = "",
    buff = "",
}

---@return PaladinSealSettings
function PaladinSealSettings:new(cfgIndex, spell, spellKnown, buff)
    local o = {
        cfgIndex = cfgIndex,
        spell = spell,
        spellKnown = spellKnown,
        buff = buff,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@type table<number, PaladinSealSettings>
local cfgIndexToSealSettingsMap = {
    [1] = PaladinSealSettings:new(1, spells.sealOfRighteousness, spellKnown.sealOfRighteousness, buffs.sealOfRighteousness),
    [2] = PaladinSealSettings:new(2, spells.sealOfJustice, spellKnown.sealOfJustice, buffs.sealOfJustice),
    [3] = PaladinSealSettings:new(3, spells.sealOfLight, spellKnown.sealOfLight, buffs.sealOfLight),
    [4] = PaladinSealSettings:new(4, spells.sealOfWisdom, spellKnown.sealOfWisdom, buffs.sealOfWisdom),
    [5] = PaladinSealSettings:new(5, spells.sealOfCommand, spellKnown.sealOfCommand, buffs.sealOfCommand),
    [6] = PaladinSealSettings:new(6, spells.sealOfCorruption, spellKnown.sealOfCorruption, buffs.sealOfCorruption),
}

function Config:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

---Apply object to change default values
---@param object PaladinConfig another config
function Config:apply(object)
    object = object or {}
    for k, v in pairs(object) do
        if self[k] == nil then
            Print("Unknown config key '" .. tostring(k) .. "', skip.")
        elseif self[k] ~= v then
            Print("Option '" .. tostring(k) .. "' changed from '" .. tostring(self[k]) .. "' to '" .. tostring(v) .. "'.")
            self[k] = v
        end
    end
end

---@class PaladinState
local State = {
    judgmentToUse = spells.judgementOfLight,
    judgmentToUseKnown = spellKnown.judgementOfLight,
    judgmentToUseDebuff = debuffs.judgementOfLight,

    defaultAura = spells.devotionAura,

    defaultBlessingSpell = spells.blessingOfMight,
    defaultBlessingKnown = spellKnown.blessingOfMight,
    defaultBlessingBuff = buffs.blessingOfMight,

    ---@type PaladinSealSettings
    defaultSeal = PaladinSealSettings:new(0, "", false, ""),
    ---@type PaladinSealSettings[]
    ignoredSeals = {}
}

function State:new()
    local o = { }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Determine state
---@param cfg PaladinConfig config
---@return void
function State:determine(cfg)
    if cfg.useJudgmentType == 2 and spellKnown.judgementOfWisdom then
        self.judgmentToUse = spells.judgementOfWisdom
        self.judgmentToUseKnown = spellKnown.judgementOfWisdom
        self.judgmentToUseDebuff = debuffs.judgementOfWisdom
    elseif cfg.useJudgmentType == 3 and spellKnown.judgementOfJustice then
        self.judgmentToUse = spells.judgementOfJustice
        self.judgmentToUseKnown = spellKnown.judgementOfJustice
        self.judgmentToUseDebuff = debuffs.judgementOfJustice
    end

    if cfgIndexToAuraSettingsMap[cfg.defaultAuraToUse] and cfgIndexToAuraSettingsMap[cfg.defaultAuraToUse].spellKnown then
        self.defaultAura = cfgIndexToAuraSettingsMap[cfg.defaultAuraToUse].spell
    end

    if cfg.defaultBlessingToUse == 2 and spellKnown.blessingOfKings then
        self.defaultBlessingSpell = spells.blessingOfKings
        self.defaultBlessingKnown = spellKnown.blessingOfKings
        self.defaultBlessingBuff = buffs.blessingOfKings
    elseif cfg.defaultBlessingToUse == 3 and spellKnown.blessingOfWisdom then
        self.defaultBlessingSpell = spells.blessingOfWisdom
        self.defaultBlessingKnown = spellKnown.blessingOfWisdom
        self.defaultBlessingBuff = buffs.blessingOfWisdom
    end

    if cfgIndexToSealSettingsMap[cfg.defaultSealToUse] and cfgIndexToSealSettingsMap[cfg.defaultSealToUse].spellKnown then
        self.defaultSeal = cfgIndexToSealSettingsMap[cfg.defaultSealToUse]
    end

    for _, sealCfgIndex in ipairs(cfg.defaultSealDoNotSwitchList) do
        if cfgIndexToSealSettingsMap[sealCfgIndex] and cfgIndexToSealSettingsMap[sealCfgIndex].spellKnown then
            table.insert(self.ignoredSeals, cfgIndexToSealSettingsMap[sealCfgIndex])
        end
    end
end

---@param cfg PaladinConfig
---@return fun(msg:string):void
local function createDbgPrintFunc(cfg)
    if cfg.debug == false then
        return function()
        end
    end

    return function(msg)
        local message = "[DEBUG] " .. msg
        GMR.Print(message)
        GMR.Log(message)
    end
end

---@class PaladinRotation
local Rotation = {
    ---@type PaladinConfig
    cfg = nil,
    ---@type PaladinState
    state = nil,
    ---@type fun(msg:string):void
    dbgPrint = function(msg)
    end
}
---@param cfg PaladinConfig
---@param state PaladinState
---@return PaladinRotation
function Rotation:new(cfg, state)
    local dbgPrint = createDbgPrintFunc(cfg)

    ---@type PaladinRotation
    local o = {
        cfg = cfg,
        state = state,
        dbgPrint = dbgPrint,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

local function HasBuffClassed(unit, buff, byPlayer)
    local hasSameClassBuff = false
    local sameClassBuffList = nil
    for _, list in ipairs(buffSameClassLists) do
        for _, buffFromList in ipairs(list) do
            if buff == buffFromList then
                hasSameClassBuff = true
                sameClassBuffList = list
                break
            end
        end
        if hasSameClassBuff then
            break
        end
    end

    if not hasSameClassBuff then
        return GMR.HasBuff(unit, buff, byPlayer)
    end

    for _, buffFromList in ipairs(sameClassBuffList) do
        if GMR.HasBuff(unit, buffFromList, byPlayer) then
            return true
        end
    end

    return false
end

---@return void
function Rotation:execute()
    if self:isStunned() then
        self.dbgPrint("player is stunned, can't do anything")
        return
    end

    if self:isSilent() then
        self.dbgPrint("player is silent, can't cast anything")
        return
    end

    if self:executeAuraChange() then
        return
    end

    if GMR.IsMoving() and IsMounted("player") then
        return
    end

    if not GMR.HasDebuff("player", debuffs.forbearance) then
        if spellKnown.handOfProtection and GMR.GetHealth("player") < self.cfg.useHandOfProtectionMinHP
            and GMR.IsCastable(spells.handOfProtection, "player")
        then
            self.dbgPrint("should cast hand of protection on player")
            GMR.Cast(spells.handOfProtection, "player")
            return
        end

        if spellKnown.divineProtection and GMR.GetHealth("player") < self.cfg.useDivineProtectionMinHP
            and GMR.IsCastable(spells.divineProtection, "player")
        then
            self.dbgPrint("should cast divine protection on player")
            GMR.Cast(spells.divineProtection, "player")
            return
        end
    end

    if self.state.defaultBlessingKnown and not HasBuffClassed("player", self.state.defaultBlessingBuff)
        and GMR.IsCastable(self.state.defaultBlessingSpell, "player")
    then
        self.dbgPrint("should cast default blessing '" .. self.state.defaultBlessingSpell .. "' on player")
        GMR.Cast(self.state.defaultBlessingSpell, "player")
        return
    end

    if self.state.defaultSeal.spellKnown and not GMR.HasBuff("player", self.state.defaultSeal.buff)
        and GMR.IsCastable(self.state.defaultSeal.spell, "player")
    then
        local alreadyHasIgnoredSeal = false
        for _, ignoreSeal in ipairs(self.state.ignoredSeals) do
            if GMR.HasBuff("player", ignoreSeal.buff) then
                alreadyHasIgnoredSeal = true
                break
            end
        end
        if not alreadyHasIgnoredSeal then
            self.dbgPrint("should cast default seal '" .. self.state.defaultSeal.spell .. "' on player")
            GMR.Cast(self.state.defaultSeal.spell, "player")
            return
        end
    end

    local isTargetAttackable = GMR.IsAlive("target") and GMR.UnitCanAttack("player", "target")
        and not GMR.IsImmune("target")

    -- Hammer of Wrath
    if spellKnown.hammerOfWrath then
        for i = 1, #GMR.Tables.Attackables do
            local attackable = GMR.Tables.Attackables[i][1]
            if GMR.ObjectExists(attackable) and GMR.IsAlive(attackable) and GMR.GetHealth(attackable) < 20
                and GMR.IsCastable(spells.hammerOfWrath, attackable)
            then
                self.dbgPrint("should cast hammer of wrath")
                GMR.Cast(spells.hammerOfWrath, attackable)
                return
            end
        end
    end

    -- Judgement
    if self.state.judgmentToUseKnown and GetSpellCooldown(self.state.judgmentToUse) == 0 and isTargetAttackable then
        if not self.cfg.useJudgmentForDebuffOnly or (self.cfg.useJudgmentForDebuffOnly
            and not GMR.HasBuff("target", self.state.judgmentToUseDebuff, true))
        then
            local unitToCast = "target"
            if self.cfg.useJudgmentTryToCleave then
                for i = 1, #GMR.Tables.Attackables do
                    local attackable = GMR.Tables.Attackables[i][1]
                    if GMR.ObjectExists(attackable) and GMR.IsCastable(self.state.judgmentToUse, attackable)
                        and GMR.GetDistance("player", attackable, "<", 10)
                        and not GMR.IsImmune(attackable)
                        and GMR.GetDebuffExpiration(attackable, self.state.judgmentToUseDebuff) < self.cfg.useJudgmentCooldown
                    then
                        unitToCast = attackable
                        break
                    end
                end
            end

            if unitToCast and GMR.IsCastable(self.state.judgmentToUse, unitToCast) then
                self.dbgPrint("should cast default judgment '" .. self.state.judgmentToUse .. "'")
                GMR.Cast(self.state.judgmentToUse, unitToCast)
                return
            end
        end
    end

    if self:cleanse("player") then
        return
    end

    if GMR.HasBuff("player", buffs.theArtOfWar) then
        if spellKnown.flashOfLight and GMR.GetHealth("player") < self.cfg.consumeArtOfWarFlashLightMinHp
            and GMR.IsCastable(spells.flashOfLight, "player")
        then
            self.dbgPrint("should cast flash of light on self to consume the art of war aura")
            GMR.Cast(spells.flashOfLight, "player")
            return
        elseif isTargetAttackable and spellKnown.exorcism and GMR.IsCastable(spells.exorcism, "target") then
            self.dbgPrint("should cast exorcism on target to consume the art of war aura")
            GMR.Cast(spells.exorcism, "target")
            return
        elseif self.cfg.consumeArtOfWarFlashLightIfAuraDepletedSoon and spellKnown.flashOfLight
            and GMR.GetBuffExpiration("player", buffs.theArtOfWar) < 2
            and GMR.GetHealth("player") < 100 and GMR.IsCastable(spells.flashOfLight, "player")
        then
            self.dbgPrint("should cast flash of light on self to consume the art of war aura. Aura will deplete soon.")
            GMR.Cast(spells.flashOfLight, "player")
            return
        end
    end

    if self:applyBlessingOfFreedom("player") then
        return
    end

    if self:executeGroupCleanse() then
        return
    end
    if self:executeHeal() then
        return
    end

    if isTargetAttackable and self.cfg.useHandOfReckoningToMakeDamage and spellKnown.handOfReckoning
        and (self.cfg.useHandOfReckoningInInstance or (not self.cfg.useHandOfReckoningInInstance and not IsInInstance()))
        and not GMR.UnitIsPlayer("target") and not GMR.UnitIsUnit("targettarget", "player")
        and GMR.IsCastable(spells.handOfReckoning, "target")
    then
        self.dbgPrint("should cast hand of reckoning to make some damage")
        GMR.Cast(spells.handOfReckoning, "target")
        return
    end

    if self.cfg.useConsecrations and spellKnown.consecrations and not GMR.IsMoving()
        and GMR.GetNumEnemies("player", 10) >= self.cfg.useConsecrationsMinEnemies
        and GMR.IsCastable(spells.consecrations, "player")
    then
        self.dbgPrint("should use consecrations")
        GMR.Cast(spells.consecrations, "player")
        return
    end

    if spellKnown.divineStorm and GMR.GetNumEnemies("player", 8) >= self.cfg.useDivineStormMinEnemies
        and GMR.IsCastable(spells.divineStorm, "player")
    then
        self.dbgPrint("should use divine storm")
        GMR.Cast(spells.divineStorm, "player")
        return
    end

    if isTargetAttackable and spellKnown.crusaderStrike and GMR.IsCastable(spells.crusaderStrike, "target") then
        self.dbgPrint("should cast crusader strike")
        GMR.Cast(spells.crusaderStrike, "target")
        return
    end

    if self:executeGroupBuff() then
        return
    end
end

---@return boolean
function Rotation:isSilent()
    return false
end

---@return boolean
function Rotation:isStunned()
    if GMR.HasDebuff("player", debuffs.hammerOfJustice) then
        return true
    end

    return false
end

---@param unit string|userdata
---@return boolean Did cleanse
function Rotation:cleanse(unit)
    if GMR.GetDistance("player", unit, ">", 40) then
        return false
    end
    if not GMR.IsAlive(unit) then
        return false
    end
    if spellKnown.cleanse and not GMR.IsCastable(spells.cleanse, unit) then
        return false
    elseif spellKnown.purify and not GMR.IsCastable(spells.purify, unit) then
        return false
    end

    local debuffNameToIndexMap = {}
    for index = 1, 40 do
        local localeName, _, _, debuffType, duration, expireAtTime = GMR.UnitDebuff(unit, index)
        if localeName and expireAtTime - GetTime() < duration - math.random(5, 10) / 10 then
            local isCleanable = false
            if spellKnown.cleanse and debuffType == "Disease" or debuffType == "Magic" or debuffType == "Poison" then
                isCleanable = true
            elseif spellKnown.purify and debuffType == "Disease" or debuffType == "Poison" then
                isCleanable = true
            end

            if isCleanable then
                debuffNameToIndexMap[localeName] = index
            end
        end
    end

    local shouldCleanIndex = self:shouldCleanse(unit, debuffNameToIndexMap)
    if shouldCleanIndex then
        local localeName, _, _, _, _, _, _, _, _, spellId = GMR.UnitDebuff(unit, shouldCleanIndex)
        local unknownPart = ""
        if not debuffIndex[localeName] then
            unknownPart = "UNKNOWN "
        end

        local spellSysName = ""
        local spellToCast = ""
        if spellKnown.cleanse then
            spellSysName = "cleanse"
            spellToCast = spells.cleanse
        elseif spellKnown.purify then
            spellSysName = "purify"
            spellToCast = spells.purify
        end

        self.dbgPrint("should cast " .. spellSysName .. " on '" .. unit .. "' to remove " .. unknownPart .. "debuff  '" .. localeName .. "':" .. tostring(spellId) .. ".")
        GMR.Cast(spells.cleanse, unit)
        return true
    end

    return false
end

--- @return number index
function Rotation:shouldCleanse(unit, debuffNameToIndexMap)
    for debuff, index in pairs(debuffNameToIndexMap) do
        if debuff == debuffs.livingBomb and GMR.GetNumPartyMembersAroundUnit(unit, 20) == 0 then
            return index
        end
    end

    for debuff, _ in pairs(debuffNameToIndexMap) do
        for _, neverDispelDebuff in ipairs(debuffNeverDispelList) do
            if neverDispelDebuff == debuff then
                return nil
            end
        end
    end

    for debuff, index in pairs(debuffNameToIndexMap) do
        for _, topPriorityDebuff in ipairs(debuffTopPriorityList) do
            if topPriorityDebuff == debuff then
                return index
            end
        end
    end

    for debuff, _ in pairs(debuffNameToIndexMap) do
        for _, notDispelDebuff in ipairs(debuffNotRecommendDispelList) do
            if notDispelDebuff == debuff then
                return nil
            end
        end
    end

    local unitClass = GMR.GetClass(unit)
    for debuff, index in pairs(debuffNameToIndexMap) do
        for whiteListDebuff, classList in pairs(debuffCleanseClassWhiteList) do
            if debuff == whiteListDebuff then
                for _, class in ipairs(classList) do
                    if class == unitClass then
                        return index
                    end
                end
            end
        end
    end

    for debuff, index in pairs(debuffNameToIndexMap) do
        local isIgnored = false
        for _, ignoredDebuff in ipairs(debuffsLowPriority) do
            if debuff == ignoredDebuff then
                isIgnored = true
                break
            end
        end

        if not isIgnored then
            return index
        end
    end

    return nil
end

---@return boolean casted something
function Rotation:executeGroupCleanse()
    if not self.cfg.groupCleanseModEnabled then
        return false
    end

    if not UnitInRaid("player") and not UnitInParty("player") then
        return false
    end

    if UnitInRaid("player") then
        for raidIndex = 1, 40 do
            local unit = "raid" .. tostring(raidIndex)
            if self:cleanse(unit) then
                return true
            end
        end
    elseif UnitInParty("player") then
        for partyIndex = 1, 4 do
            local unit = "party" .. tostring(partyIndex)
            if self:cleanse(unit) then
                return true
            end
        end
    end

    return false
end

function Rotation:applyBlessingOfFreedom(unit)
    if not self.cfg.useBlessingOfFreedom then
        return false
    end
    if GMR.GetDistance("player", unit, ">", 30) then
        return false
    end
    if not spellKnown.blessingOfFreedom or not GMR.IsCastable(spells.blessingOfFreedom, unit) then
        return false
    end

    for index = 1, 40 do
        local localeName, _, _, _, duration, expireAtTime, _, _, _, spellId = GMR.UnitDebuff(unit, index)
        if localeName and expireAtTime - GetTime() < duration - math.random(5, 10) / 10 then
            for i, debuffFromRegistry in ipairs(debuffBlessingOfFreedomList) do
                if debuffFromRegistry == localeName then
                    self.dbgPrint("should cast blessing of freedom on '" .. unit .. "' to remove debuff  '" ..
                        localeName .. "':" .. tostring(spellId) .. ".")
                    GMR.Cast(spells.blessingOfFreedom, unit)
                    return true
                end
            end
        end
    end
end

---@return boolean did cast something
function Rotation:executeGroupBuff()
    if not self.cfg.groupBuffModEnabled or GMR.GetMana("player") < self.cfg.groupBuffModMinMana then
        return false
    end

    if not UnitInRaid("player") and not UnitInParty("player") then
        return false
    end

    if UnitInRaid("player") then
        for raidIndex = 1, 40 do
            local unit = "raid" .. tostring(raidIndex)
            if self:buff(unit) then
                return true
            end
        end
    elseif UnitInParty("player") then
        for partyIndex = 1, 4 do
            local unit = "party" .. tostring(partyIndex)
            if self:buff(unit) then
                return true
            end
        end
    end

    return false
end

---@return boolean did cast something
function Rotation:buff(unit)
    if not GMR.IsAlive(unit) then
        return false
    end

    local unitClass = GMR.GetClass(unit)
    local hasBlessingOfMight = HasBuffClassed(unit, buffs.blessingOfMight)
    local hasBlessingOfKings = HasBuffClassed(unit, buffs.blessingOfKings)
    local hasBlessingOfMightByPlayer = HasBuffClassed(unit, buffs.blessingOfMight, true)
    local hasBlessingOfKingsByPlayer = HasBuffClassed(unit, buffs.blessingOfKings, true)
    if not hasBlessingOfMight and (unitClass == CLASS_ROGUE or unitClass == CLASS_DEATHKNIGHT or unitClass == CLASS_HUNTER or unitClass == CLASS_PALADIN
        or unitClass == CLASS_WARRIOR)
    then
        if GMR.IsCastable(spells.blessingOfMight, unit) then
            self.dbgPrint("should buff '" .. unit .. "' with blessing of might")
            GMR.Cast(spells.blessingOfMight, unit)
            return true
        end
    end
    if not hasBlessingOfKings and (unitClass == CLASS_DRUID or unitClass == CLASS_MAGE or unitClass == CLASS_PRIEST
        or unitClass == CLASS_SHAMAN or unitClass == CLASS_WARLOCK)
    then
        if GMR.IsCastable(spells.blessingOfKings, unit) then
            self.dbgPrint("should buff '" .. unit .. "' with blessing of kings")
            GMR.Cast(spells.blessingOfKings, unit)
            return true
        end
    end

    if not hasBlessingOfMightByPlayer and not hasBlessingOfKingsByPlayer then
        if not hasBlessingOfKings and GMR.IsCastable(spells.blessingOfKings, unit) then
            self.dbgPrint("should buff '" .. unit .. "' with blessing of kings as additional buff")
            GMR.Cast(spells.blessingOfKings, unit)
            return true
        end
    end

    return false
end

---@return boolean did cast something
function Rotation:executeHeal()
    if not self.cfg.healModEnabled then
        return false
    end

    if not UnitInRaid("player") and not UnitInParty("player") then
        return false
    end

    if self:heal("player") then
        return true
    end

    if UnitHealth("focus") > 0 then
        if self:heal("focus") then
            return true
        end
    end

    if GMR.GetMana("player") < 20 then
        return false
    end

    if UnitInRaid("player") then
        for raidIndex = 1, 40 do
            local unit = "raid" .. tostring(raidIndex)
            if self:heal(unit) then
                return true
            end
        end
    elseif UnitInParty("player") then
        for partyIndex = 1, 4 do
            local unit = "party" .. tostring(partyIndex)
            if self:heal(unit) then
                return true
            end
        end
    end

    return false
end

---@param unit string|userdata
---@return boolean
function Rotation:heal(unit)
    if GMR.GetDistance("player", unit, ">", 40) then
        return false
    end
    if not GMR.IsAlive(unit) then
        return false
    end

    local missingHealth = GMR.UnitHealthMax(unit) - GMR.UnitHealth(unit)
    if GMR.IsMoving() then
        if missingHealth >= self.cfg.healModHolyShockHealAmount and GMR.IsCastable(spells.holyShock, unit) then
            self.dbgPrint("should cast holy shock on '" .. unit .. "' to heal while moving")
            GMR.Cast(spells.holyShock, unit)
            return true
        elseif missingHealth >= (self.cfg.healModFlashOfLightHealAmount * 1.5) -- crit 100%
            and GMR.HasBuff("player", buffs.infusionOfLight)
            and GMR.IsCastable(spells.flashOfLight, unit)
        then
            self.dbgPrint("should cast flash of light on " .. unit .. " to heal with 'infusion of light' buff while moving")
            GMR.Cast(spells.flashOfLight, unit)
            return true
        end
    else
        if missingHealth >= self.cfg.healModHolyLightHealAmount and GMR.IsCastable(spells.holyLight, unit) then
            self.dbgPrint("should cast holy light on " .. unit .. " while standing")
            GMR.Cast(spells.holyLight, unit)
            return true
        elseif missingHealth >= self.cfg.healModHolyShockHealAmount and GMR.IsCastable(spells.holyShock, unit) then
            self.dbgPrint("should cast holy shock on " .. unit .. " while standing")
            GMR.Cast(spells.holyShock, unit)
            return true
        elseif missingHealth >= self.cfg.healModFlashOfLightHealAmount and GMR.IsCastable(spells.flashOfLight, unit) then
            self.dbgPrint("should cast flash of light on " .. unit .. " while standing")
            GMR.Cast(spells.flashOfLight, unit)
            return true
        end
    end

    return false
end

---@return boolean is casted anything
function Rotation:executeAuraChange()
    if self.cfg.useCrusaderAuraWhileMounted and spellKnown.crusaderAura and IsMounted("player") then
        if not GMR.HasBuff("player", spells.crusaderAura)
            and GMR.GetDestinationDistance() > self.cfg.useCrusaderAuraWhileMounterMinDistance
            and GMR.IsCastable(spells.crusaderAura, "player")
        then
            self.dbgPrint("should change aura to crusader")
            GMR.Cast(spells.crusaderAura, "player")
            return true
        end

        -- should do nothing while mounted
        return false
    end

    if not GMR.HasBuff("player", self.state.defaultAura) and GMR.IsCastable(self.state.defaultAura, "player") then
        self.dbgPrint("should change aura to default '" .. self.state.defaultAura .. "'")
        GMR.Cast(self.state.defaultAura, "player")
        return true
    end

    if not GMR.HasBuff("player", self.state.defaultAura, true) then
        for _, cfgIndex in ipairs(self.cfg.defaultAuraChangeIfAlreadyExist) do
            local auraSettings = cfgIndexToAuraSettingsMap[cfgIndex]
            if auraSettings and auraSettings.spellKnown then
                if GMR.HasBuff("player", auraSettings.buff) then
                    if GMR.HasBuff("player", auraSettings.buff, true) then
                        -- it's mine aura, no check further
                        break
                    end
                else
                    self.dbgPrint("should cast alternative aura with index #" .. tostring(cfgIndex) .. ", '" .. auraSettings.spell .. "'")
                    GMR.Cast(auraSettings.spell, "player")
                    return true
                end
            end
        end
    end

    return false
end

do
    local isSuccess, err = pcall(function()
        if GMR.GetClass("player") == "PALADIN" then
            Print("Rotation would be initialized")

            local cfg = Config:new()
            cfg:apply(AMST_SHARE["CR>P/R.CFG"])

            local state = State:new()
            state:determine(cfg)

            local rotation = Rotation:new(cfg, state)
            local executeRotationFunc = function()
                local isSuccess, err = pcall(rotation.execute, rotation)
                if not isSuccess then
                    Error("Can't launch rotation: " .. err)
                end
            end

            if cfg.groupCleanseModEnabled and cfg.useCombatRotationLauncher then
                GMR.Print("You have turned on `groupCleanseModEnabled`;therefore, you should turn off `useCombatRotationLauncher` to get better results")
            end

            if cfg.useCombatRotationLauncher then
                local resultFunction = nil
                if GMR.CustomCombatConditions == nil then
                    resultFunction = executeRotationFunc
                else
                    Print("There is another combat conditions, it will be merged with this rotation")
                    local oldCombatConditions = GMR.CustomCombatConditions
                    resultFunction = function()
                        local isSuccess, err = pcall(oldCombatConditions)
                        if not isSuccess then
                            Error("Can't launch previous custom combat rotation: " .. err)
                        end
                        executeRotationFunc()
                    end
                end

                GMR.CustomCombatConditions = resultFunction
                C_Timer.NewTicker(1, function()
                    if GMR.CustomCombatConditions ~= resultFunction then
                        GMR.CustomCombatConditions = resultFunction
                        Error("Something changed GMR.CustomCombatConditions func, it was changed back!")
                    end
                end)

                C_Timer.NewTicker(0.5, function()
                    rotation:executeAuraChange()
                end)
            else
                C_Timer.NewTicker(0.1, function()
                    if (not GMR.IsExecuting() or not GMR.IsAlive()) then
                        return
                    end

                    if GMR.IsEating("player") or GMR.IsDrinking("player") then
                        return false
                    end

                    executeRotationFunc()
                end)
            end

            Print("Rotation fully initialed and turned on.")
        end
    end)

    if not isSuccess then
        Error(err)
    end
end