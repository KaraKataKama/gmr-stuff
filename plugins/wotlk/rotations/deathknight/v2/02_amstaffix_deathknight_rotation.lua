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
local VERSION = "v2.0.0"
local printMsgPrefix = "[CR>DK/B|" .. VERSION .. "] "
---Print message with CR prefix
---@param msg string
local function Print(msg)
    GMR.Print(printMsgPrefix .. msg)
end

local function Error(msg)
    Print(printMsgPrefix .. "[ERROR] " .. msg)
end

local spells = {
    plagueStrike = GetSpellInfo(45462),
    bloodPlague = GetSpellInfo(55078), -- plagues strike's debuff
    icyTouch = GetSpellInfo(45477),
    frostFever = GetSpellInfo(55095), -- icy touch's debuff
    pestilence = GetSpellInfo(50842),
    heartStrike = GetSpellInfo(55050),
    bloodStrike = GetSpellInfo(45902),
    deathStrike = GetSpellInfo(49998),
    runeTap = GetSpellInfo(48982),
    vampiricBlood = GetSpellInfo(55233),
    iceboundFortitude = GetSpellInfo(48792),
    bloodBoil = GetSpellInfo(48721),
    bloodTap = GetSpellInfo(45529),
    deathCoil = GetSpellInfo(47541),
    bloodPresence = GetSpellInfo(48266),
    frostPresence = GetSpellInfo(48263),
    unholyPresence = GetSpellInfo(48265),
    runeStrike = GetSpellInfo(56815),
    raiseDead = GetSpellInfo(46584),
    deathPact = GetSpellInfo(48743),
    hornOfWinter = GetSpellInfo(57330),
    mindFreeze = GetSpellInfo(47528),
    strangulate = GetSpellInfo(47476),
    deathGrip = GetSpellInfo(49576),
    arcaneTorrent = GetSpellInfo(50613),
    unholyFrenzy = GetSpellInfo(49016),
    deathAndDecay = GetSpellInfo(49936),
    dancingRuneWeapon = GetSpellInfo(49028),
    markOfBlood = GetSpellInfo(49005),
    corpseExplosion = GetSpellInfo(51328),
    frostStrike = GetSpellInfo(51418),
    obliterate = GetSpellInfo(51423),
    howlingBlast = GetSpellInfo(51409),
    unbreakableArmor = GetSpellInfo(51271),
    deathGate = GetSpellInfo(50977),
    chainsOfIce = GetSpellInfo(45524),
}

local spellKnown = {
    pestilence = GMR.IsSpellKnown(spells.pestilence),
    heartStrike = GMR.IsSpellKnown(spells.heartStrike),
    deathStrike = GMR.IsSpellKnown(spells.deathStrike),
    runeTap = GMR.IsSpellKnown(spells.runeTap),
    vampiricBlood = GMR.IsSpellKnown(spells.vampiricBlood),
    iceboundFortitude = GMR.IsSpellKnown(spells.iceboundFortitude),
    bloodBoil = GMR.IsSpellKnown(spells.bloodBoil),
    bloodTap = GMR.IsSpellKnown(spells.bloodTap),
    frostPresence = GMR.IsSpellKnown(spells.frostPresence),
    unholyPresence = GMR.IsSpellKnown(spells.unholyPresence),
    runeStrike = GMR.IsSpellKnown(spells.runeStrike),
    raiseDead = GMR.IsSpellKnown(spells.raiseDead),
    hornOfWinter = GMR.IsSpellKnown(spells.hornOfWinter),
    mindFreeze = GMR.IsSpellKnown(spells.mindFreeze),
    strangulate = GMR.IsSpellKnown(spells.strangulate),
    deathGrip = GMR.IsSpellKnown(spells.deathGrip),
    arcaneTorrent = GMR.IsSpellKnown(spells.arcaneTorrent),
    unholyFrenzy = GMR.IsSpellKnown(spells.unholyFrenzy),
    deathAndDecay = GMR.IsSpellKnown(spells.deathAndDecay),
    dancingRuneWeapon = GMR.IsSpellKnown(spells.dancingRuneWeapon),
    markOfBlood = GMR.IsSpellKnown(spells.markOfBlood),
    corpseExplosion = GMR.IsSpellKnown(spells.corpseExplosion),
    frostStrike = GMR.IsSpellKnown(spells.frostStrike),
    obliterate = GMR.IsSpellKnown(spells.obliterate),
    howlingBlast = GMR.IsSpellKnown(spells.howlingBlast),
    unbreakableArmor = GMR.IsSpellKnown(spells.unbreakableArmor),
    deathGate = GMR.IsSpellKnown(spells.deathGate),
    chainsOfIce = GMR.IsSpellKnown(spells.chainsOfIce),
}

local glyphSpells = {
    glyphOfDisease = GetSpellInfo(63334),
    glyphOfPestilence = GetSpellInfo(59309),
    glyphOfRaiseDead = GetSpellInfo(60200),
}

local buffs = {
    killingMachine = GetSpellInfo(51124),
    freezingFog = GetSpellInfo(59052),
    bloodTap = GetSpellInfo(45529),
}

---@class DeathKnightBloodConfig
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

    useDeathStrike = true,
    ---Min HP to start using Death Strike more often
    minHPToUseDeathStrikeMoreOften = 90,
    minHPToUseDeathPact = 80,

    useFrostStrike = true,

    useObliterate = true,

    useHowlingBlast = true,
    useHowlingBlastMinEnemies = 3,

    useUnbreakableArmor = true,

    usePlagueStrikeAsFiller = false,

    useIcyTouchAsFiller = false,

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

    useTrinket1 = false,
    useTrinket1Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful

    useTrinket2 = false,
    useTrinket2Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful
}
function Config:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

---Apply object to change default values
---@param object DeathKnightBloodConfig another config
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

local TRINKET_TYPE_SELF_BUFF = 1
local TRINKET_TYPE_TARGET_HARMFUL = 2
local TRINKET_TYPE_AOE_HARMFUL = 3

---@class Trinket
local Trinket = {
    index = 0,
    inventoryId = 0,
    type = 0
}

---@return Trinket
function Trinket:new(index, type)
    local inventoryId = 0
    if index == 1 then
        inventoryId = 13
    elseif index == 2 then
        inventoryId = 14
    else
        error("invalid trinket index '" .. tostring(type) .. "'")
    end

    if type ~= TRINKET_TYPE_SELF_BUFF and type ~= TRINKET_TYPE_TARGET_HARMFUL and type ~= TRINKET_TYPE_AOE_HARMFUL then
        error("invalid type '" .. tostring(type) .. "'")
    end

    local o = {
        index = index,
        inventoryId = inventoryId,
        type = type,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

local RUNE_TYPE_BLOOD = 1
local RUNE_TYPE_UNHOLY = 2
local RUNE_TYPE_FROST = 3
local RUNE_TYPE_DEATH = 4

local prevDbgMessage = ""
---@class DeathKnightBloodState
local State = {
    defaultPresenceSkill = spells.bloodPresence,
    hasGlyphOfDisease = false,
    pestilenceRadius = 10,
    raiseDeadConsumeItem = true,
    lastRuneStrikeUsed = 0,
    explodedCorpses = {},
    lastCorpseIdForExplosion = "",
    lastInterruptAttempt = 0,
    ---@type Trinket[]
    trinkets = {},
}

function State:new()
    local o = { }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Determine state
---@param cfg DeathKnightBloodConfig config
---@return void
function State:determine(cfg)
    if cfg.defaultPresence == 1 then
        self.defaultPresenceSkill = spells.bloodPresence
    elseif cfg.defaultPresence == 2 and spellKnown.frostPresence then
        self.defaultPresenceSkill = spells.frostPresence
    elseif cfg.defaultPresence == 3 and spellKnown.unholyPresence then
        self.defaultPresenceSkill = spells.unholyPresence
    end
    Print("Character will use '" .. self.defaultPresenceSkill .. "' as default presence")

    for socketId = 1, GetNumGlyphSockets() do
        local enabled, _, spellId = GetGlyphSocketInfo(socketId)
        if enabled then
            local spellInfo = GetSpellInfo(spellId)
            if spellInfo == glyphSpells.glyphOfDisease then
                Print("Character has Glyph of Disease, CR should use pestilence to renew debuffs.")
                self.hasGlyphOfDisease = true
            elseif spellInfo == glyphSpells.glyphOfPestilence then
                Print("Character has Glyph of Pestilence, radius of Pestilence is 15 now.")
                self.pestilenceRadius = 15
            elseif spellInfo == glyphSpells.glyphOfRaiseDead then
                self.raiseDeadConsumeItem = false
            end
        end
    end

    local trinketIndexes = {}
    if cfg.useTrinket1 then
        table.insert(trinketIndexes, 1)
    end
    if cfg.useTrinket2 then
        table.insert(trinketIndexes, 2)
    end
    for _, index in ipairs(trinketIndexes) do
        local trinket = Trinket:new(index, cfg.useTrinket1Type)
        table.insert(self.trinkets, trinket)
        Print("Character will use trinket with inventory id '" .. tostring(trinket.inventoryId) .. "' type " .. tostring(trinket.type) .. " ")
    end
end

---@param cfg DeathKnightBloodConfig
---@return fun(msg:string):void
local function createDbgPrintFunc(cfg)
    if cfg.debug == false then
        return function()
        end
    end

    return function(msg)
        if msg == prevDbgMessage then
            return
        end
        local message = "[DEBUG] " .. msg
        prevDbgMessage = msg
        GMR.Print(message)
        GMR.Log(message)
    end
end

---@class DeathKnightBloodRotation
local Rotation = {
    ---@type DeathKnightBloodConfig
    cfg = nil,
    ---@type DeathKnightBloodState
    state = nil,
    ---@type fun(msg:string):void
    dbgPrint = function(msg)
    end
}
---@param cfg DeathKnightBloodConfig
---@param state DeathKnightBloodState
---@return DeathKnightBloodRotation
function Rotation:new(cfg, state)
    local dbgPrint = createDbgPrintFunc(cfg)

    ---@type DeathKnightBloodRotation
    local o = {
        cfg = cfg,
        state = state,
        dbgPrint = dbgPrint,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@return boolean spell casted
function Rotation:useSpellWithPreBloodTap(spell, unit)
    -- spell cd and shortage on runes use same cooldown info, so we can understand which type of CD it only by CD
    -- duration
    local cooldownDuration = select(2, GetSpellCooldown(spell))
    if cooldownDuration > 10 then
        return false
    end

    if not GMR.IsCastable(spell, unit) and spellKnown.bloodTap then
        if GetSpellCooldown(spells.bloodTap) == 0 then
            self.dbgPrint("should cast blood tap to generate blood rune")
            GMR.Cast(spells.bloodTap, "player")
            return true
        end
    end

    if GMR.IsCastable(spell, unit) then
        self.dbgPrint("should cast blood tap to generate blood rune")
        GMR.Cast(spell, unit)
        return true
    end

    return false
end

---@class DKRune
local DKRune = {
    type = 0,
    isReady = false,
    cooldownStart = 0,
    cooldownDuration = 0,
    remainingTime = 0,
    restoresInTime = 0,
    reservedFor = "",
}

---@return DKRune
function DKRune:new(type, isReady, cooldownStart, cooldownDuration)
    local o = {
        type = type,
        isReady = isReady,
        cooldownStart = cooldownStart,
        cooldownDuration = cooldownDuration,
        remainingTime = cooldownStart + cooldownDuration - GetTime(),
        restoresInTime = cooldownStart + cooldownDuration,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@class DKRunes
local DKRunes = {
    ---@type DKRune[]
    runes = {}
}

---@return DKRunes
function DKRunes:new()
    local runes = {}
    for id = 1, 6 do
        local cdStart, cdDur, isReady = GetRuneCooldown(id)
        table.insert(runes, DKRune:new(GetRuneType(id), isReady, cdStart, cdDur))
    end
    local o = {
        runes = runes,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@param reserveId string
---@param type number
---@param startPeriod number
---@param endPeriod number
function DKRunes:willBeReadyOrReserve(reserveId, type, startPeriod, endPeriod)
    if startPeriod - GetTime() > 10 then
        -- have enough time to use rune and wait to restore
        --Print("very long time, should not do anything")
        return
    end

    for _, rune in ipairs(self.runes) do
        if rune.type == type or rune.type == RUNE_TYPE_DEATH then
            if not rune.isReady and rune.restoresInTime < endPeriod then
                --Print("rune will restore in time")
                -- rune will be ready
                return
            end
        end
    end

    -- runes, that would be ready not found, let's reserve
    for _, rune in ipairs(self.runes) do
        if rune.type == type or rune.type == RUNE_TYPE_DEATH then
            if rune.isReady then
                --Print("should reserve rune")
                rune.reservedFor = reserveId
                return
            end
        end
    end
end

function DKRunes:canConsume(reserveId, blood, frost, unholy)
    local runesToConsume = {
        [RUNE_TYPE_BLOOD] = blood,
        [RUNE_TYPE_FROST] = frost,
        [RUNE_TYPE_UNHOLY] = unholy,
    }
    for _, rune in ipairs(self.runes) do
        for type, _ in pairs(runesToConsume) do
            if rune.isReady and (rune.reservedFor == "" or (rune.reservedFor == reserveId)) and rune.type == type then
                if runesToConsume[type] > 0 then
                    runesToConsume[type] = runesToConsume[type] - 1
                    break
                end
            end
        end
    end

    for _, rune in ipairs(self.runes) do
        for type, _ in pairs(runesToConsume) do
            if rune.isReady and (rune.reservedFor == "" or (rune.reservedFor == reserveId)) and rune.type == RUNE_TYPE_DEATH then
                if runesToConsume[type] > 0 then
                    runesToConsume[type] = runesToConsume[type] - 1
                    break
                end
            end
        end
    end

    for runeType, runesCharges in pairs(runesToConsume) do
        if runesCharges > 0 then
            --Print("could not consume " .. tostring(runesCharges) .. " of '" .. tostring(runeType) .. "' type.")
            return false
        end
    end

    return true
end

function DKRunes:summary()
    local runesSummary = {
        [RUNE_TYPE_BLOOD] = 0,
        [RUNE_TYPE_FROST] = 0,
        [RUNE_TYPE_UNHOLY] = 0,
        [RUNE_TYPE_DEATH] = 0,
    }
    for _, rune in ipairs(self.runes) do
        if rune.isReady then
            runesSummary[rune.type] = runesSummary[rune.type] + 1
        end
    end

    return runesSummary
end

local function GetDebuffExpiration(unit, debuff, byPlayer)
    local spellName, expiration
    local byPlayer = byPlayer or false
    for i = 1, 40 do
        if byPlayer == true then
            spellName, _, _, _, _, expiration = GMR.UnitDebuff(unit, i, nil, "player")
        else
            spellName, _, _, _, _, expiration = GMR.UnitDebuff(unit, i)
        end
        if spellName and spellName == debuff then
            if expiration - GMR.GetTime() > 0 then
                return expiration - GMR.GetTime()
            elseif expiration == 0 then
                return 99999
            end
        end
    end
    return 0
end

---@return void
function Rotation:execute()
    local spellToCheckGCD = spells.chainsOfIce
    local runes = DKRunes:new()
    local power = GMR.UnitPower("player")
    local powerMax = GMR.UnitPowerMax("player")
    if GMR.GetTime() > self.state.lastInterruptAttempt + 0.5 then
        for i = 1, #GMR.Tables.Attackables do
            local attackable = GMR.Tables.Attackables[i][1]
            if GMR.ObjectExists(attackable) and GMR.IsInterruptable(attackable) and GMR.UnitCastingTime(attackable, 2) then
                if spellKnown.mindFreeze and GMR.IsCastable(spells.mindFreeze) and GMR.IsSpellInRange(spells.mindFreeze, attackable)
                    and GetSpellCooldown(spells.mindFreeze) == 0 then
                    self.dbgPrint("should use mind freeze to interrupt cast.")
                    GMR.Cast(spells.mindFreeze, attackable)
                    self.state.lastInterruptAttempt = GetTime()
                    return
                elseif spellKnown.arcaneTorrent and GMR.GetDistance("player", attackable, "<", 8)
                    and GMR.IsCastable(spells.arcaneTorrent, "player") and GetSpellCooldown(spells.arcaneTorrent) == 0
                then
                    self.dbgPrint("should use arcane torrent to interrupt cast.")
                    GMR.Cast(spells.arcaneTorrent, "player")
                    self.state.lastInterruptAttempt = GetTime()
                    return
                elseif self.cfg.useStrangulateToInterruptCasts and spellKnown.strangulate
                    and GMR.GetDistance("player", attackable, ">", 8) and GMR.IsSpellInRange(spells.strangulate, attackable)
                    and GMR.IsCastable(spells.strangulate, attackable) and GetSpellCooldown(spells.strangulate) == 0
                then
                    self.dbgPrint("should use strangulate to interrupt cast.")
                    GMR.Cast(spells.strangulate, attackable)
                    self.state.lastInterruptAttempt = GetTime()
                    return
                elseif self.cfg.useDeathGripToInterruptCasts and spellKnown.deathGrip
                    and GMR.GetDistance("player", attackable, ">", 10) and GMR.IsSpellInRange(spells.deathGrip, attackable)
                    and GMR.IsCastable(spells.deathGrip, attackable) and GetSpellCooldown(spells.deathGrip) == 0
                then
                    self.dbgPrint("should use death grip to interrupt cast.")
                    GMR.Cast(spells.deathGrip, attackable)
                    self.state.lastInterruptAttempt = GetTime()
                    return
                end
                break -- if nothing works, just stop iteration
            end
        end
    end

    if self.cfg.useUnholyFrenzyOnSelf and spellKnown.unholyFrenzy and GMR.IsCastable(spells.unholyFrenzy, "player")
        and GMR.GetNumEnemies("player", 10) >= self.cfg.useUnholyFrenzyMinEnemies
    then
        self.dbgPrint("should cast unholy frenzy")
        GMR.Cast(spells.unholyFrenzy, "player")
        return
    end

    if spellKnown.raiseDead and GetSpellCooldown(spells.raiseDead) > 0 then
        local secondsLeftAfterCast = GetTime() - GetSpellCooldown(spells.raiseDead)
        if secondsLeftAfterCast >= 45 and secondsLeftAfterCast <= 60 and GMR.GetHealth("player") < self.cfg.minHPToUseDeathPact
            and GMR.IsCastable(spells.deathPact, "player")
        then
            self.dbgPrint("should cast Death Pact to heal")
            GMR.Cast(spells.deathPact, "player")
            return
        end
    end

    if self.cfg.useRuneStrike and spellKnown.runeStrike and GMR.IsCastable(spells.runeStrike, "target")
        and GetTime() - self.state.lastRuneStrikeUsed > 0.5
    then
        self.dbgPrint("should turn on rune strike")
        GMR.Cast(spells.runeStrike, "target")
        self.state.lastRuneStrikeUsed = GetTime()
    end

    --self.dbgPrint("should do")

    if self.cfg.useDeathCoilOnEnemy and GMR.GetNumEnemies("player", 10) <= self.cfg.useDeathCoilOnEnemyMaxEnemies
        and UnitPower("player", 6) >= 85 and GMR.IsCastable(spells.deathCoil, "target")
        and GMR.IsSpellInRange(spells.deathCoil, "target")
    then
        self.dbgPrint("use death coil to spend rune power")
        GMR.Cast(spells.deathCoil, "target")
        return
    end

    --- Testing in progress, do not use it on your own
    if self.cfg.useCorpseExplosion and spellKnown.corpseExplosion and GMR.IsCastable(spells.corpseExplosion, "player")
        and GMR.GetNumEnemies("player", 10) >= self.cfg.useCorpseExplosionMinEnemies
    then
        local corpseIdToExplode = ""
        local objs = GMR.GetNearbyObjects(10)
        for id, _ in pairs(objs) do
            local createTypeId = GMR.ObjectCreatureTypeId(id)
            if createTypeId then
                if GMR.UnitIsDead(id) then
                    local found = false
                    for alreadyExplodedCorpseObjectId, _ in pairs(self.state.explodedCorpses) do
                        if alreadyExplodedCorpseObjectId == id then
                            found = true
                            break
                        end
                    end
                    if not found then
                        corpseIdToExplode = id
                        self.dbgPrint("Has corpse to explode id:'" .. tostring(id) .. "'; create-type-id:'" .. tostring(createTypeId) .. "'")
                        break
                    end
                end
            end
        end
        if corpseIdToExplode ~= "" then
            self.dbgPrint("should use corpse explosion")
            GMR.Cast(spells.corpseExplosion, "player")
            self.state.lastCorpseIdForExplosion = corpseIdToExplode
            return
        end
    end
    if GetSpellCooldown(spells.corpseExplosion) ~= 0 and self.state.lastCorpseIdForExplosion then
        self.state.explodedCorpses[self.state.lastCorpseIdForExplosion] = GetTime() + 60
        self.state.lastCorpseIdForExplosion = ""
    end

    if GMR.HasBuff("player", self.state.defaultPresenceSkill) then
        if self.state.defaultPresenceSkill ~= spells.frostPresence and GMR.GetHealth("player") < self.cfg.minHpToChangeToFrostPresence
            and GMR.IsCastable(spells.frostPresence, "player")
        then
            self.dbgPrint("should use frost presence")
            GMR.Cast(spells.frostPresence, "player")
            return
        end
    else
        if GMR.GetHealth("player") >= 99 and GMR.IsCastable(self.state.defaultPresenceSkill, "player") then
            self.dbgPrint("should use default presence '" .. self.state.defaultPresenceSkill .. "'")
            GMR.Cast(self.state.defaultPresenceSkill, "player")
            return
        end
    end

    if spellKnown.vampiricBlood and GMR.GetHealth("player") <= self.cfg.vampiricBloodHpUse then
        local casted = self:useSpellWithPreBloodTap(spells.vampiricBlood, "player")
        if casted then
            return
        end
    end

    if spellKnown.runeTap and GMR.GetHealth("player") <= self.cfg.runeTapHpUse then
        local casted = self:useSpellWithPreBloodTap(spells.runeTap, "player")
        if casted then
            return
        end
    end

    --self.dbgPrint("should do stage 2")

    if spellKnown.iceboundFortitude and GMR.IsCastable(spells.iceboundFortitude, "player")
        and GMR.GetHealth("player") <= self.cfg.iceboundFortitudeHpUse
    then
        self.dbgPrint("should use icebound fortitude")
        GMR.Cast(spells.iceboundFortitude, "player")
        return
    end

    if spellKnown.dancingRuneWeapon and GMR.IsCastable(spells.dancingRuneWeapon, "target")
        and GMR.GetNumEnemies("player", 10) >= self.cfg.useDancingRuneWeaponMinEnemies
    then
        self.dbgPrint("should cast dancing weapon")
        GMR.Cast(spells.dancingRuneWeapon, "target")
        return
    end

    if spellKnown.markOfBlood and GMR.IsCastable(spells.markOfBlood, "target")
        and GMR.GetHealth("player") <= self.cfg.useMarkOfBloodMinHP
        and GMR.GetNumEnemies("player", 10) >= self.cfg.useMarkOfBloodMinEnemies
    then
        self.dbgPrint("should use mark of blood")
        GMR.Cast(spells.markOfBlood, "target")
        return
    end

    if self.cfg.useUnbreakableArmor and spellKnown.unbreakableArmor and spellKnown.bloodTap
        and GMR.IsCastable(spells.unbreakableArmor, "player")
        and GMR.GetDistance("player", "target", "<", 6)
    then
        local bloodTabUnbreakableArmorComboStage = 0
        if GMR.HasBuff("player", buffs.bloodTap) then
            bloodTabUnbreakableArmorComboStage = 1
        end

        if bloodTabUnbreakableArmorComboStage == 0 then
            if not runes.runes[1].isReady or not runes.runes[2].isReady and GMR.IsCastable(spells.bloodTap, "player") then
                self.dbgPrint("should cast blood tap for unbreakable armor combo")
                GMR.Cast(spells.bloodTap, "player")
                return
            end
        elseif bloodTabUnbreakableArmorComboStage == 1 then
            self.dbgPrint("should cast unbreakable armor")
            GMR.Cast(spells.unbreakableArmor, "player")
            return
        end
    end

    if self.cfg.useDeathAndDecay and spellKnown.deathAndDecay
        and GMR.GetNumEnemies("player", 10) >= self.cfg.useDeathAndDecayMinEnemies
        and GMR.IsCastable(spells.deathAndDecay, "player")
    then
        self.dbgPrint("should use death and decay")
        GMR.Cast(spells.deathAndDecay, "player")
        return
    end

    local targetBloodPlagueDuration = GetDebuffExpiration("target", spells.bloodPlague, true)
    local targetFrostFeverDuration = GetDebuffExpiration("target", spells.frostFever, true)

    local shouldCastPlagueStrike = false
    local shouldCastIcyTouch = false
    if self.state.hasGlyphOfDisease then
        if targetBloodPlagueDuration <= 0 then
            shouldCastPlagueStrike = true
        end
        if targetFrostFeverDuration <= 0 then
            shouldCastIcyTouch = true
        end
    else
        if targetBloodPlagueDuration <= 3 then
            shouldCastPlagueStrike = true
        end
        if targetFrostFeverDuration <= 3 then
            shouldCastIcyTouch = true
        end
    end

    if shouldCastIcyTouch and GMR.IsCastable(spells.icyTouch, "target")
        and GMR.IsSpellInRange(spells.icyTouch, "target")
    then
        self.dbgPrint("renew frost fever debuff with icy touch")
        GMR.Cast(spells.icyTouch, "target")
        return
    end

    if shouldCastPlagueStrike and GMR.IsCastable(spells.plagueStrike, "target")
        and GMR.IsSpellInRange(spells.plagueStrike, "target")
    then
        self.dbgPrint("renew blood plague debuff with plague strike")
        GMR.Cast(spells.plagueStrike, "target")
        return
    end

    local enemiesToTransferDebuff = 0
    local enemiesWithDebuff = 0
    local enemiesAround = 0
    for i = 1, #GMR.Tables.Attackables do
        local attackable = GMR.Tables.Attackables[i][1]
        -- gather debuff info for pestilence
        if GMR.ObjectExists(attackable) and GMR.UnitLevel(attackable) > 1
            and GMR.GetDistance("player", attackable, "<", self.state.pestilenceRadius)
        then
            local attackableBloodPlagueDuration = GetDebuffExpiration(attackable, spells.bloodPlague, true)
            local attackableFrostFeverDuration = GetDebuffExpiration(attackable, spells.frostFever, true)
            if attackableBloodPlagueDuration < 3 or attackableFrostFeverDuration < 3 then
                enemiesToTransferDebuff = enemiesToTransferDebuff + 1
            else
                enemiesWithDebuff = enemiesWithDebuff + 1
            end
        end

        -- blood boil information gathering
        if GMR.ObjectExists(attackable) and GMR.GetDistance("player", attackable, "<", 10) then
            enemiesAround = enemiesAround + 1
        end
    end

    --self.dbgPrint("should do stage 3")

    if self.state.hasGlyphOfDisease and targetBloodPlagueDuration > 0 and targetFrostFeverDuration > 0 then
        runes:willBeReadyOrReserve("pestilence", RUNE_TYPE_BLOOD,
            GetTime() + targetBloodPlagueDuration - 5,
            GetTime() + targetBloodPlagueDuration - 2)
    end

    local needToCastPestilenceSpell = false
    if targetBloodPlagueDuration > 3 and targetFrostFeverDuration > 3 and enemiesToTransferDebuff > 0 then
        needToCastPestilenceSpell = true
    elseif self.state.hasGlyphOfDisease and (targetBloodPlagueDuration > 0 and targetBloodPlagueDuration < 5)
        and (targetFrostFeverDuration > 0 and targetFrostFeverDuration < 5)
    then
        needToCastPestilenceSpell = true
    end

    if needToCastPestilenceSpell and spellKnown.pestilence then
        if GMR.IsCastable(spells.pestilence, "target") then
            self.dbgPrint("should use Pestilence")
            GMR.Cast(spells.pestilence, "target")
            return
        end
    end

    for _, trinket in ipairs(self.state.trinkets) do
        local itemId = GetInventoryItemID("player", trinket.inventoryId)
        local cooldownStart, duration = GetItemCooldown(itemId)
        if cooldownStart == 0 and GMR.IsCastable(spellToCheckGCD, "player") then
            if trinket.type == TRINKET_TYPE_AOE_HARMFUL then
                if not GMR.IsMoving() and GMR.GetNumEnemies("player", 15) >= 1 then
                    self.dbgPrint("should use trinket #" .. tostring(trinket.index) .. " as AOE")
                    GMR.RunMacroText("/use [@player] " .. tostring(trinket.inventoryId))
                    return
                end
            elseif trinket.type == TRINKET_TYPE_SELF_BUFF  and GMR.GetDistance("player", "target", "<", 6) then
                self.dbgPrint("should use trinket #" .. tostring(trinket.index) .. " as self-buff")
                GMR.Use(itemId)
                return
            elseif trinket.type == TRINKET_TYPE_TARGET_HARMFUL and GMR.GetDistance("player", "target", "<", 6) then
                self.dbgPrint("should use trinket #" .. tostring(trinket.index) .. " as target harmful")
                GMR.Use(itemId)
                return
            end
        end
    end

    if GMR.HasBuff("player", buffs.freezingFog) and spellKnown.howlingBlast
        and GMR.IsCastable(spells.howlingBlast, "target")
    then
        self.dbgPrint("should cast howling blast to consume freezing for buff")
        GMR.Cast(spells.howlingBlast, "target")
        return
    end

    -- we need hp in first place, after that we will use some damage spells
    if self.cfg.useDeathStrike and GMR.GetHealth("player") < self.cfg.minHPToUseDeathStrikeMoreOften
        and GMR.IsCastable(spells.deathStrike, "target")
        and GMR.IsSpellInRange(spells.deathStrike, "target")
    then
        self.dbgPrint("should use death strike to heal yourself")
        GMR.Cast(spells.deathStrike, "target")
        return
    end

    if enemiesAround >= self.cfg.minEnemiesCountToRaiseDead then
        if GMR.IsCastable(spells.raiseDead, "player") and not self.state.raiseDeadConsumeItem then
            self.dbgPrint("should use raise dead")
            GMR.Cast(spells.raiseDead)
            return
        end
    end

    if not (needToCastPestilenceSpell and spellKnown.pestilence) then
        local shouldUseBloodFillers = true
        if self.cfg.useBloodFillersWithBloodRunesOnly and runes:summary()[RUNE_TYPE_BLOOD] == 0 then
            shouldUseBloodFillers = false
        end
        if shouldUseBloodFillers and runes:canConsume("", 1, 0, 0) then
            local shouldUseBloodBoil = self.cfg.bloodBoilEnabled and enemiesAround >= self.cfg.bloodBoilMinEnemies
            if shouldUseBloodBoil and GMR.IsCastable(spells.bloodBoil, "player") then
                self.dbgPrint("should use blood boil")
                GMR.Cast(spells.bloodBoil, "player")
                return
            end
            if spellKnown.heartStrike then
                if GMR.IsCastable(spells.heartStrike, "target") and GMR.IsSpellInRange(spells.heartStrike, "target") then
                    self.dbgPrint("should use heart strike")
                    GMR.Cast(spells.heartStrike, "target")
                    return
                end
            else
                if GMR.IsCastable(spells.bloodStrike, "target") and GMR.IsSpellInRange(spells.bloodStrike, "target") then
                    self.dbgPrint("should use blood strike")
                    GMR.Cast(spells.bloodStrike, "target")
                    return
                end
            end
        end
    end

    if self.cfg.useHowlingBlast and spellKnown.howlingBlast
        and GMR.GetNumEnemies("target", 10) >= self.cfg.useHowlingBlastMinEnemies - 1
        and GMR.IsCastable(spells.howlingBlast, "target")
        and runes:canConsume("", 0, 1, 1)
    then
        self.dbgPrint("should cast howling blast to make aoe dmg")
        GMR.Cast(spells.howlingBlast, "target")
        return
    end

    -- filler to spent unholy and frost runes
    if spellKnown.deathStrike and self.cfg.useDeathStrike then
        if GMR.IsCastable(spells.deathStrike, "target") and GMR.IsSpellInRange(spells.deathStrike, "target") then
            self.dbgPrint("should use death strike as a filler")
            GMR.Cast(spells.deathStrike, "target")
            return
        end
    elseif self.cfg.useObliterate and spellKnown.obliterate and GMR.IsCastable(spells.obliterate, "target")
        and runes:canConsume("", 0, 1, 1)
    then
        self.dbgPrint("should use obliterate as a filler")
        GMR.Cast(spells.obliterate, "target")
        return
    else
        if self.cfg.usePlagueStrikeAsFiller and GMR.IsCastable(spells.plagueStrike, "target")
            and GMR.IsSpellInRange(spells.plagueStrike, "target")
        then
            self.dbgPrint("should use plague strike as a filler")
            GMR.Cast(spells.plagueStrike, "target")
            return
        end

        if self.cfg.useIcyTouchAsFiller and GMR.IsCastable(spells.icyTouch, "target")
            and GMR.IsSpellInRange(spells.icyTouch, "target")
        then
            self.dbgPrint("should use icy touch as a filler")
            GMR.Cast(spells.icyTouch, "target")
            return
        end
    end

    if self.cfg.useFrostStrike and spellKnown.frostStrike and GMR.IsCastable(spells.frostStrike, "target") then
        if power > (powerMax - 25) then
            self.dbgPrint("should cast frost strike to consume power")
            GMR.Cast(spells.frostStrike, "target")
            return
        elseif GMR.HasBuff("player", buffs.killingMachine) then
            self.dbgPrint("should cast frost strike to consume killing machine buff")
            GMR.Cast(spells.frostStrike, "target")
            return
        end
    end

    if not GMR.HasBuff("player", spells.hornOfWinter) and GMR.IsCastable(spells.hornOfWinter, "player")
        and GetSpellCooldown(spells.hornOfWinter) == 0
    then
        self.dbgPrint("should use horn of winter")
        GMR.Cast(spells.hornOfWinter, "player")
        return
    end
end

do
    local isSuccess, err = pcall(function()
        if AMST_SHARE["CR/DK/B.LOADED"] == true then
            Error("There are two versions of the rotation uploaded. It may happen if you downloaded 02_amstaffix_deathknight_blood_rotation.lua file.")
            Error("Please delete it, or change `Config.onlineLoad` to `false` if you want to use offline version of rotation.")
            return
        end
        AMST_SHARE["CR/DK/B.LOADED"] = true

        -- turn on only for death knight class
        if GMR.GetClass("player") == "DEATHKNIGHT" then
            Print("Rotation would be initialized")

            local cfg = Config:new()
            cfg:apply(AMST_SHARE["CR/DK/B.CFG"])

            local state = State:new()
            state:determine(cfg)

            C_Timer.NewTicker(60, function()
                local time = GetTime()
                for k, expire in pairs(state.explodedCorpses) do
                    if expire > time then
                        state.explodedCorpses[k] = nil
                    end
                end
            end)

            local rotation = Rotation:new(cfg, state)
            local rotationFunc = function()
                local isSuccess, err = pcall(rotation.execute, rotation)
                if not isSuccess then
                    Error("Can't launch rotation: " .. err)
                end
            end

            if cfg.useCombatRotationLauncher then
                local resultFunction = nil
                if GMR.CustomCombatConditions == nil then
                    resultFunction = rotationFunc
                else
                    Print("There is another combat conditions, it will be merged with this rotation")
                    local oldCombatConditions = GMR.CustomCombatConditions
                    resultFunction = function()
                        local isSuccess, err = pcall(oldCombatConditions)
                        if not isSuccess then
                            Error("can't launch previous custom combat rotation: " .. err)
                        end
                        rotationFunc()
                    end
                end

                GMR.CustomCombatConditions = resultFunction
                C_Timer.NewTicker(1, function()
                    if GMR.CustomCombatConditions ~= resultFunction then
                        GMR.CustomCombatConditions = resultFunction
                        Error("Something changed GMR.CustomCombatConditions func, it was changed back!")
                    end
                end)
            else
                C_Timer.NewTicker(0.1, function()
                    if (not GMR.IsExecuting() or not GMR.IsAlive()) then
                        return
                    end

                    rotationFunc()
                end)
            end

            Print("Rotation fully initialed and turned on.")
        end
    end)

    if not isSuccess then
        Error(err)
    end
end
