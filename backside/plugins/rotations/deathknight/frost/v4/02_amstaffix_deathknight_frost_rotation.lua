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

local ID = "CR>DK/F"
local VERSION = "v4.0.2"

---@class DeathKnightFrostV4Config
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = false,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = true,
    ---Use online loading feature to get last updates
    onlineLoad = true,
    ---Character names to force load that rotation
    forceLoadForCharacters = {},

    ---Min HP to cast Icebound Fortitude
    iceboundFortitudeHpUse = 50,
    bloodBoilEnabled = true,
    ---Should bot use only blood runes for blood-runes offensive spells like Blood Boil, Heart/Blood Strike
    useBloodFillersWithBloodRunesOnly = false,
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

    minHPToUseDeathPact = 80,

    useHowlingBlastMinEnemies = 3,

    useStrangulateToInterruptCasts = true,
    useDeathGripToInterruptCasts = true,

    useDeathAndDecay = false,
    useDeathAndDecayMinEnemies = 3,

    useDeathCoilOnEnemy = false,
    useDeathCoilOnEnemyMaxEnemies = 1,

    useCorpseExplosion = false,
    useCorpseExplosionMinEnemies = 3,

    useTrinket1 = false,
    useTrinket1Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful

    useTrinket2 = false,
    useTrinket2Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful

    ---@type AmstLibCombatRotation
    cr = nil
}

---@param cr AmstLibCombatRotation
---@return DeathKnightFrostV4Config
function Config:new(cr)
    local o = {
        cr = cr,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Apply object to change default values
---@param object DeathKnightFrostV4Config another config
function Config:apply(object)
    object = object or {}
    for k, v in pairs(object) do
        if self[k] == nil then
            self.cr:print("Unknown config key '" .. tostring(k) .. "', skip.")
        elseif self[k] ~= v then
            self.cr:print("Option '" .. tostring(k) .. "' changed from '" .. tostring(self[k]) .. "' to '" .. tostring(v) .. "'.")
            self[k] = v
        end
    end
end

---@class DeathKnightFrostV4State
local State = {
    defaultPresenceSkill = amstlib.CONST.SPELL.bloodPresence,
    hasGlyphOfDisease = false,
    pestilenceRadius = 10,
    raiseDeadConsumeItem = true,
    lastRuneStrikeUsed = 0,
    explodedCorpses = {},
    lastCorpseIdForExplosion = "",
    lastInterruptAttempt = 0,
    frostStrikeCost = 40,
}

function State:new()
    local o = { }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Determine state
---@param cr AmstLibCombatRotation
---@param cfg DeathKnightFrostV4Config config
---@return void
function State:determine(cr, cfg)
    if cfg.defaultPresence == 1 then
        self.defaultPresenceSkill = amstlib.CONST.SPELL.bloodPresence
    elseif cfg.defaultPresence == 2 and amstlib.CONST.SPELL_KNOWN.frostPresence then
        self.defaultPresenceSkill = amstlib.CONST.SPELL.frostPresence
    elseif cfg.defaultPresence == 3 and amstlib.CONST.SPELL_KNOWN.unholyPresence then
        self.defaultPresenceSkill = amstlib.CONST.SPELL.unholyPresence
    end
    cr:print("Character will use '" .. self.defaultPresenceSkill .. "' as default presence")

    for socketId = 1, GetNumGlyphSockets() do
        local enabled, _, spellId = GetGlyphSocketInfo(socketId)
        if enabled then
            local spellInfo = GetSpellInfo(spellId)
            if spellInfo == amstlib.CONST.GLYPH.glyphOfDisease then
                cr:print("Character has Glyph of Disease, CR should use pestilence to renew debuffs.")
                self.hasGlyphOfDisease = true
            elseif spellInfo == amstlib.CONST.GLYPH.glyphOfPestilence then
                cr:print("Character has Glyph of Pestilence, radius of Pestilence is 15 now.")
                self.pestilenceRadius = 15
            elseif spellInfo == amstlib.CONST.GLYPH.glyphOfRaiseDead then
                self.raiseDeadConsumeItem = false
            end
        end
    end
end

local RUNE_TYPE_BLOOD = 1
local RUNE_TYPE_UNHOLY = 2
local RUNE_TYPE_FROST = 3
local RUNE_TYPE_DEATH = 4

---@class DeathKnightFrostV4Rune
local DeathKnightFrostV4Rune = {
    type = 0,
    isReady = false,
    cooldownStart = 0,
    cooldownDuration = 0,
    remainingTime = 0,
    restoresInTime = 0,
    reservedFor = "",
}

---@return DeathKnightFrostV4Rune
function DeathKnightFrostV4Rune:new(type, isReady, cooldownStart, cooldownDuration)
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

---@class DeathKnightFrostV4Runes
local DeathKnightFrostV4Runes = {
    ---@type DeathKnightFrostV4Rune[]
    runes = {}
}

---@return DeathKnightFrostV4Runes
function DeathKnightFrostV4Runes:new()
    local runes = {}
    for id = 1, 6 do
        local cdStart, cdDur, isReady = GetRuneCooldown(id)
        table.insert(runes, DeathKnightFrostV4Rune:new(GetRuneType(id), isReady, cdStart, cdDur))
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
function DeathKnightFrostV4Runes:willBeReadyOrReserve(reserveId, type, startPeriod, endPeriod)
    if startPeriod - GetTime() > 10 then
        -- have enough time to use rune and wait to restore
        return
    end

    for _, rune in ipairs(self.runes) do
        if rune.type == type or rune.type == RUNE_TYPE_DEATH then
            if not rune.isReady and rune.restoresInTime < endPeriod then
                -- rune will be ready
                return
            end
        end
    end

    -- runes, that would be ready not found, let's reserve
    for _, rune in ipairs(self.runes) do
        if rune.type == type or rune.type == RUNE_TYPE_DEATH then
            if rune.isReady then
                rune.reservedFor = reserveId
                return
            end
        end
    end
end

function DeathKnightFrostV4Runes:canConsume(reserveId, blood, frost, unholy)
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

function DeathKnightFrostV4Runes:summary()
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

---@class DeathKnightFrostV4Rotation
local Rotation = {
    ---@type DeathKnightFrostV4Config
    cfg = nil,
    ---@type DeathKnightFrostV4State
    state = nil,
    ---@type AmstLibCombatRotation
    cr = nil,
    ---@type AmstLibTrinketer
    trinketer = nil,
}
---@param cfg DeathKnightFrostV4Config
---@param state DeathKnightFrostV4State
---@param cr AmstLibCombatRotation
---@param trinketer AmstLibTrinketer
---@return DeathKnightFrostV4Rotation
function Rotation:new(cfg, state, cr, trinketer)
    ---@type DeathKnightFrostV4Rotation
    local o = {
        cfg = cfg,
        state = state,
        cr = cr,
        trinketer = trinketer,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@return void
function Rotation:execute()
    if self:isStunned() then
        self.cr:printDbg("player is stunned, can't do anything")
        return
    end

    if self:isSilent() then
        self.cr:printDbg("player is silent, can't cast anything")
        return
    end

    if GMR.IsMoving() and IsMounted("player") then
        self.cr:printDbg("is moving or mounted")
        return
    end

    local runes = DeathKnightFrostV4Runes:new()
    local runesSummary = runes:summary()
    local power = GMR.UnitPower("player")
    local powerMax = GMR.UnitPowerMax("player")

    if amstlib.CONST.SPELL_KNOWN.iceboundFortitude and GMR.IsCastable(amstlib.CONST.SPELL.iceboundFortitude, "player")
        and GMR.GetHealth("player") <= self.cfg.iceboundFortitudeHpUse
    then
        self.cr:printDbg("should use icebound fortitude")
        GMR.Cast(amstlib.CONST.SPELL.iceboundFortitude, "player")
        return
    end

    if GMR.GetTime() > self.state.lastInterruptAttempt + 0.5 then
        for i = 1, #GMR.Tables.Attackables do
            local attackable = GMR.Tables.Attackables[i][1]
            if GMR.ObjectExists(attackable) and GMR.IsInterruptable(attackable) and GMR.UnitCastingTime(attackable, 2) then
                if amstlib.CONST.SPELL_KNOWN.mindFreeze and GMR.IsCastable(amstlib.CONST.SPELL.mindFreeze) and GMR.IsSpellInRange(amstlib.CONST.SPELL.mindFreeze, attackable)
                    and GetSpellCooldown(amstlib.CONST.SPELL.mindFreeze) == 0 then
                    self.cr:printDbg("should use mind freeze to interrupt cast.")
                    GMR.Cast(amstlib.CONST.SPELL.mindFreeze, attackable)
                    self.state.lastInterruptAttempt = GetTime()
                    return
                elseif amstlib.CONST.SPELL_KNOWN.arcaneTorrent and GMR.GetDistance("player", attackable, "<", 8)
                    and GMR.IsCastable(amstlib.CONST.SPELL.arcaneTorrent, "player") and GetSpellCooldown(amstlib.CONST.SPELL.arcaneTorrent) == 0
                then
                    self.cr:printDbg("should use arcane torrent to interrupt cast.")
                    GMR.Cast(amstlib.CONST.SPELL.arcaneTorrent, "player")
                    self.state.lastInterruptAttempt = GetTime()
                    return
                elseif self.cfg.useStrangulateToInterruptCasts and amstlib.CONST.SPELL_KNOWN.strangulate
                    and GMR.GetDistance("player", attackable, ">", 8) and GMR.IsSpellInRange(amstlib.CONST.SPELL.strangulate, attackable)
                    and GMR.IsCastable(amstlib.CONST.SPELL.strangulate, attackable) and GetSpellCooldown(amstlib.CONST.SPELL.strangulate) == 0
                then
                    self.cr:printDbg("should use strangulate to interrupt cast.")
                    GMR.Cast(amstlib.CONST.SPELL.strangulate, attackable)
                    self.state.lastInterruptAttempt = GetTime()
                    return
                elseif self.cfg.useDeathGripToInterruptCasts and amstlib.CONST.SPELL_KNOWN.deathGrip
                    and GMR.GetDistance("player", attackable, ">", 10) and GMR.IsSpellInRange(amstlib.CONST.SPELL.deathGrip, attackable)
                    and GMR.IsCastable(amstlib.CONST.SPELL.deathGrip, attackable) and GetSpellCooldown(amstlib.CONST.SPELL.deathGrip) == 0
                then
                    self.cr:printDbg("should use death grip to interrupt cast.")
                    GMR.Cast(amstlib.CONST.SPELL.deathGrip, attackable)
                    self.state.lastInterruptAttempt = GetTime()
                    return
                end
                break -- if nothing works, just stop iteration
            end
        end
    end

    if amstlib.CONST.SPELL_KNOWN.runeStrike and GMR.IsCastable(amstlib.CONST.SPELL.runeStrike, "target")
        and GetTime() - self.state.lastRuneStrikeUsed > 0.5
    then
        self.cr:printDbg("should turn on rune strike")
        GMR.Cast(amstlib.CONST.SPELL.runeStrike, "target")
        self.state.lastRuneStrikeUsed = GetTime()
    end

    if self.cfg.useCorpseExplosion and amstlib.CONST.SPELL_KNOWN.corpseExplosion and GMR.IsCastable(amstlib.CONST.SPELL.corpseExplosion, "player")
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
                        self.cr:printDbg("Has corpse to explode id:'" .. tostring(id) .. "'; create-type-id:'" .. tostring(createTypeId) .. "'")
                        break
                    end
                end
            end
        end
        if corpseIdToExplode ~= "" then
            self.cr:printDbg("should use corpse explosion")
            GMR.Cast(amstlib.CONST.SPELL.corpseExplosion, "player")
            self.state.lastCorpseIdForExplosion = corpseIdToExplode
            return
        end
    end
    if GetSpellCooldown(amstlib.CONST.SPELL.corpseExplosion) ~= 0 and self.state.lastCorpseIdForExplosion then
        self.state.explodedCorpses[self.state.lastCorpseIdForExplosion] = GetTime() + 60
        self.state.lastCorpseIdForExplosion = ""
    end

    if GMR.HasBuff("player", amstlib.CONST.BUFF.freezingFog) and amstlib.CONST.SPELL_KNOWN.howlingBlast
        and GMR.IsCastable(amstlib.CONST.SPELL.howlingBlast, "target")
    then
        self.cr:printDbg("should cast howling blast to consume freezing fog buff")
        GMR.Cast(amstlib.CONST.SPELL.howlingBlast, "target")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.howlingBlast
        and GMR.GetNumEnemies("target", 10) >= self.cfg.useHowlingBlastMinEnemies - 1
        and GMR.IsCastable(amstlib.CONST.SPELL.howlingBlast, "target")
        and runes:canConsume("", 0, 1, 1)
    then
        self.cr:printDbg("should cast howling blast to make aoe dmg")
        GMR.Cast(amstlib.CONST.SPELL.howlingBlast, "target")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.raiseDead and GetSpellCooldown(amstlib.CONST.SPELL.raiseDead) > 0 then
        local secondsLeftAfterCast = GetTime() - GetSpellCooldown(amstlib.CONST.SPELL.raiseDead)
        if secondsLeftAfterCast >= 45 and secondsLeftAfterCast <= 60 and GMR.GetHealth("player") < self.cfg.minHPToUseDeathPact
            and GMR.IsCastable(amstlib.CONST.SPELL.deathPact, "player")
        then
            self.cr:printDbg("should cast Death Pact to heal")
            GMR.Cast(amstlib.CONST.SPELL.deathPact, "player")
            return
        end
    end

    if GMR.HasBuff("player", self.state.defaultPresenceSkill) then
        if self.state.defaultPresenceSkill ~= amstlib.CONST.SPELL.frostPresence and GMR.GetHealth("player") < self.cfg.minHpToChangeToFrostPresence
            and GMR.IsCastable(amstlib.CONST.SPELL.frostPresence, "player")
        then
            self.cr:printDbg("should use frost presence")
            GMR.Cast(amstlib.CONST.SPELL.frostPresence, "player")
            return
        end
    else
        if GMR.GetHealth("player") >= 99 and GMR.IsCastable(self.state.defaultPresenceSkill, "player") then
            self.cr:printDbg("should use default presence '" .. self.state.defaultPresenceSkill .. "'")
            GMR.Cast(self.state.defaultPresenceSkill, "player")
            return
        end
    end

    if self.cfg.useDeathCoilOnEnemy and GMR.GetNumEnemies("player", 10) <= self.cfg.useDeathCoilOnEnemyMaxEnemies
        and UnitPower("player", 6) >= 85 and GMR.IsCastable(amstlib.CONST.SPELL.deathCoil, "target")
        and GMR.IsSpellInRange(amstlib.CONST.SPELL.deathCoil, "target")
    then
        self.cr:printDbg("use death coil to spend rune power")
        GMR.Cast(amstlib.CONST.SPELL.deathCoil, "target")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.unbreakableArmor and amstlib.CONST.SPELL_KNOWN.bloodTap
        and GMR.IsCastable(amstlib.CONST.SPELL.unbreakableArmor, "player")
        and GMR.GetDistance("player", "target", "<", 6)
    then
        local bloodTabUnbreakableArmorComboStage = 0
        if GMR.HasBuff("player", amstlib.CONST.BUFF.bloodTap) then
            bloodTabUnbreakableArmorComboStage = 1
        end

        if bloodTabUnbreakableArmorComboStage == 0 then
            if not runes.runes[1].isReady or not runes.runes[2].isReady and GMR.IsCastable(amstlib.CONST.SPELL.bloodTap, "player") then
                self.cr:printDbg("should cast blood tap for unbreakable armor combo")
                GMR.Cast(amstlib.CONST.SPELL.bloodTap, "player")
                return
            end
        elseif bloodTabUnbreakableArmorComboStage == 1 then
            self.cr:printDbg("should cast unbreakable armor")
            GMR.Cast(amstlib.CONST.SPELL.unbreakableArmor, "player")
            return
        end
    end

    if self.cfg.useDeathAndDecay and amstlib.CONST.SPELL_KNOWN.deathAndDecay
        and GMR.GetNumEnemies("player", 10) >= self.cfg.useDeathAndDecayMinEnemies
        and GMR.IsCastable(amstlib.CONST.SPELL.deathAndDecay, "player")
    then
        self.cr:printDbg("should use death and decay")
        GMR.Cast(amstlib.CONST.SPELL.deathAndDecay, "player")
        return
    end

    local targetBloodPlagueDuration = amstlib.GetDebuffExpiration("target", amstlib.CONST.SPELL.bloodPlague, true)
    local targetFrostFeverDuration = amstlib.GetDebuffExpiration("target", amstlib.CONST.SPELL.frostFever, true)

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

    if shouldCastIcyTouch and GMR.IsCastable(amstlib.CONST.SPELL.icyTouch, "target")
        and GMR.IsSpellInRange(amstlib.CONST.SPELL.icyTouch, "target")
    then
        self.cr:printDbg("renew frost fever debuff with icy touch")
        GMR.Cast(amstlib.CONST.SPELL.icyTouch, "target")
        return
    end

    if shouldCastPlagueStrike and GMR.IsCastable(amstlib.CONST.SPELL.plagueStrike, "target")
        and GMR.IsSpellInRange(amstlib.CONST.SPELL.plagueStrike, "target")
    then
        self.cr:printDbg("renew blood plague debuff with plague strike")
        GMR.Cast(amstlib.CONST.SPELL.plagueStrike, "target")
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
            local attackableBloodPlagueDuration = amstlib.GetDebuffExpiration(attackable, amstlib.CONST.SPELL.bloodPlague, true)
            local attackableFrostFeverDuration = amstlib.GetDebuffExpiration(attackable, amstlib.CONST.SPELL.frostFever, true)
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

    --self.cr:printDbg("should do stage 3")

    if self.state.hasGlyphOfDisease and targetBloodPlagueDuration > 0 and targetFrostFeverDuration > 0 then
        runes:willBeReadyOrReserve("pestilence", RUNE_TYPE_BLOOD,
            GetTime() + targetBloodPlagueDuration - 6,
            GetTime() + targetBloodPlagueDuration - 4)
    end

    local needToCastPestilenceSpell = false
    if targetBloodPlagueDuration > 3 and targetFrostFeverDuration > 3 and enemiesToTransferDebuff > 0 then
        needToCastPestilenceSpell = true
    elseif self.state.hasGlyphOfDisease and (targetBloodPlagueDuration > 0 and targetBloodPlagueDuration < 5)
        and (targetFrostFeverDuration > 0 and targetFrostFeverDuration < 5)
    then
        needToCastPestilenceSpell = true
    end

    if needToCastPestilenceSpell and amstlib.CONST.SPELL_KNOWN.pestilence then
        if GMR.IsCastable(amstlib.CONST.SPELL.pestilence, "target") then
            self.cr:printDbg("should use Pestilence")
            GMR.Cast(amstlib.CONST.SPELL.pestilence, "target")
            return
        end
    end

    if amstlib.CONST.SPELL_KNOWN.frostStrike and GMR.IsCastable(amstlib.CONST.SPELL.frostStrike, "target")
        and power > (powerMax - 35)
    then
        self.cr:printDbg("should cast frost strike to prevent power overflow")
        GMR.Cast(amstlib.CONST.SPELL.frostStrike, "target")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.empowerRuneWeapon and runesSummary[RUNE_TYPE_UNHOLY] == 0 and runesSummary[RUNE_TYPE_FROST] == 0
        and ((runesSummary[RUNE_TYPE_BLOOD] == 0 and runesSummary[RUNE_TYPE_DEATH] == 1)
        or (runesSummary[RUNE_TYPE_BLOOD] == 1 and runesSummary[RUNE_TYPE_DEATH] == 0))
        and GMR.IsCastable(amstlib.CONST.SPELL.empowerRuneWeapon, "player")
    then
        self.cr:printDbg("should cast empower rune weapon")
        GMR.Cast(amstlib.CONST.SPELL.empowerRuneWeapon, "player")
        return
    end

    if self.trinketer:useTrinkets() then
        return
    end

    if enemiesAround >= self.cfg.minEnemiesCountToRaiseDead then
        if GMR.IsCastable(amstlib.CONST.SPELL.raiseDead, "player") and not self.state.raiseDeadConsumeItem then
            self.cr:printDbg("should use raise dead")
            GMR.Cast(amstlib.CONST.SPELL.raiseDead)
            return
        end
    end

    -- filler to spent unholy and frost runes
    if amstlib.CONST.SPELL_KNOWN.obliterate and GMR.IsCastable(amstlib.CONST.SPELL.obliterate, "target")
        and runes:canConsume("", 0, 1, 1)
    then
        self.cr:printDbg("should use obliterate as a filler")
        GMR.Cast(amstlib.CONST.SPELL.obliterate, "target")
        return
    end

    if not (needToCastPestilenceSpell and amstlib.CONST.SPELL_KNOWN.pestilence) then
        local shouldUseBloodFillers = true
        if self.cfg.useBloodFillersWithBloodRunesOnly and runesSummary[RUNE_TYPE_BLOOD] == 0 then
            shouldUseBloodFillers = false
        end
        if shouldUseBloodFillers and runes:canConsume("", 1, 0, 0) then
            local shouldUseBloodBoil = self.cfg.bloodBoilEnabled and enemiesAround >= self.cfg.bloodBoilMinEnemies
            if shouldUseBloodBoil and GMR.IsCastable(amstlib.CONST.SPELL.bloodBoil, "player") then
                self.cr:printDbg("should use blood boil")
                GMR.Cast(amstlib.CONST.SPELL.bloodBoil, "player")
                return
            end
            if amstlib.CONST.SPELL_KNOWN.heartStrike then
                if GMR.IsCastable(amstlib.CONST.SPELL.heartStrike, "target") and GMR.IsSpellInRange(amstlib.CONST.SPELL.heartStrike, "target") then
                    self.cr:printDbg("should use heart strike")
                    GMR.Cast(amstlib.CONST.SPELL.heartStrike, "target")
                    return
                end
            else
                if GMR.IsCastable(amstlib.CONST.SPELL.bloodStrike, "target") and GMR.IsSpellInRange(amstlib.CONST.SPELL.bloodStrike, "target") then
                    self.cr:printDbg("should use blood strike")
                    GMR.Cast(amstlib.CONST.SPELL.bloodStrike, "target")
                    return
                end
            end
        end
    end

    if amstlib.CONST.SPELL_KNOWN.frostStrike and GMR.IsCastable(amstlib.CONST.SPELL.frostStrike, "target") then
        local shouldCastFrostStrike = false
        if GMR.HasBuff("player", amstlib.CONST.BUFF.killingMachine) then
            shouldCastFrostStrike = true
        end

        if shouldCastFrostStrike then
            self.cr:printDbg("should cast frost strike to consume killing machine buff")
            GMR.Cast(amstlib.CONST.SPELL.frostStrike, "target")
            return
        end

    end

    if not GMR.HasBuff("player", amstlib.CONST.SPELL.hornOfWinter) and GMR.IsCastable(amstlib.CONST.SPELL.hornOfWinter, "player")
        and GetSpellCooldown(amstlib.CONST.SPELL.hornOfWinter) == 0
    then
        self.cr:printDbg("should use horn of winter")
        GMR.Cast(amstlib.CONST.SPELL.hornOfWinter, "player")
        return
    end
end

---@return boolean
function Rotation:isSilent()
    return false
end

---@return boolean
function Rotation:isStunned()
    return false
end

do
    local ok, err = pcall(function()
        local cr = amstlib:getCombatRotation(ID)
        cr:initialize(
            VERSION,
            function()
                if GMR.GetClass("player") ~= amstlib.CONST.CLASS.DEATHKNIGHT then
                    cr:printDbg("player is not Death Knight, skip")
                    return false
                end

                cr:printDbg("player is Death Knight, should make next check")

                local playerName = GMR.UnitName("player")
                for _, name in ipairs(cr:getConfig()["forceLoadForCharacters"] or {}) do
                    if playerName == name then
                        cr:printDbg("force load for character " .. name)
                        return true
                    end
                end

                if amstlib.Util.getDeepestTalentTab() == 2 then
                    cr:printDbg("player has proper talents tree, loading rotation")
                    return true
                end

                cr:printDbg("player is not suitable for rotation, skip")
                return false
            end,
            function()
                local cfg = Config:new(cr)
                cfg:apply(cr:getConfig())

                local state = State:new()
                state:determine(cr, cfg)

                C_Timer.NewTicker(60, function()
                    local time = GetTime()
                    for k, expire in pairs(state.explodedCorpses) do
                        if expire > time then
                            state.explodedCorpses[k] = nil
                        end
                    end
                end)

                local trinketer = AmstLibTrinketer:new(cr)
                trinketer:initialize(amstlib.CONST.SPELL.chainsOfIce)

                local rotation = Rotation:new(cfg, state, cr, trinketer)
                return function()
                    rotation:execute()
                end
            end
        )
    end)
    if not ok then
        GMR.Print("[" .. ID .. "|" .. VERSION .. "]" .. "[ERROR] " .. err)
    end
end