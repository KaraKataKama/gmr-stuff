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

local ID = "CR>R/O"
local VERSION = "v1.0.0"

local IsCastable = amstlib.createIsCastableFunc(amstlib.CONST.SPELL.kick)

---@class RogueConfig
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = false,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = true,
    ---Use online loading feature to get last updates
    onlineLoad = true,

    useTrinket1 = false,
    useTrinket1Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful

    useTrinket2 = false,
    useTrinket2Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful

    ---@type AmstLibCombatRotation
    cr = nil
}

---@param cr AmstLibCombatRotation
---@return RogueConfig
function Config:new(cr)
    local o = {
        cr = cr,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Apply object to change default values
---@param object RogueConfig another config
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

---@class RogueState
local State = {
    eyeBeamPreparePowerConsumeCount = 0,
}

function State:new()
    local o = { }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Determine state
---@param cfg RogueConfig config
---@return void
function State:determine(cfg)
end

---@class RogueRotation
local Rotation = {
    ---@type RogueConfig
    cfg = nil,
    ---@type RogueState
    state = nil,
    ---@type AmstLibCombatRotation
    cr = nil,
    ---@type AmstLibTrinketer
    trinketer = nil,
}
---@param cfg RogueConfig
---@param state RogueState
---@param cr AmstLibCombatRotation
---@param trinketer AmstLibTrinketer
---@return RogueRotation
function Rotation:new(cfg, state, cr, trinketer)
    ---@type RogueRotation
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

    local power = GMR.UnitPower("player")
    local powerMax = GMR.UnitPowerMax("player")
    local comboPoints = GMR.UnitPower("player", 4)
    local comboPointMax = GMR.UnitPowerMax("player", 4)
    local comboPointsMinToSpend = 5
    local shouldUseFinisher = comboPoints >= comboPointsMinToSpend

    local sinisterStrikeCPGen = 1
    local pistolShotCPGen = 1
    local echoingReprimandCPGen = 2
    if GMR.HasBuff("player", amstlib.CONST.BUFF.broadside, true) then
        sinisterStrikeCPGen = sinisterStrikeCPGen + 1
        pistolShotCPGen = pistolShotCPGen + 1
        echoingReprimandCPGen = echoingReprimandCPGen + 1
    end
    if GMR.HasBuff("player", amstlib.CONST.BUFF.opportunity, true) then
        pistolShotCPGen = pistolShotCPGen + 1
    end

    local rollTheBonesBuffCount = 0
    local rollTheBonesHasBroadside = false
    local rollTheBonesHasTrueBearing = false
    for index = 1, 20 do
        local name, _, stacks, _, duration = GMR.UnitBuff("player", index, nil, "player")
        if name then
            -- roll the bones buffs
            if duration > 20 then
                if name == amstlib.CONST.BUFF.grandMelee then
                    rollTheBonesBuffCount = rollTheBonesBuffCount + 1
                elseif name == amstlib.CONST.BUFF.broadside then
                    rollTheBonesBuffCount = rollTheBonesBuffCount + 1
                    rollTheBonesHasBroadside = true
                elseif name == amstlib.CONST.BUFF.ruthlessPrecision then
                    rollTheBonesBuffCount = rollTheBonesBuffCount + 1
                elseif name == amstlib.CONST.BUFF.buriedTreasure then
                    rollTheBonesBuffCount = rollTheBonesBuffCount + 1
                elseif name == amstlib.CONST.BUFF.skullAndCrossbones then
                    rollTheBonesBuffCount = rollTheBonesBuffCount + 1
                elseif name == amstlib.CONST.BUFF.trueBearing then
                    rollTheBonesBuffCount = rollTheBonesBuffCount + 1
                    rollTheBonesHasTrueBearing = true
                elseif name == amstlib.CONST.BUFF.grandMelee then
                    rollTheBonesBuffCount = rollTheBonesBuffCount + 1
                end
            end

            if name == amstlib.CONST.BUFF.echoingReprimand and stacks == comboPoints then
                --self.cr:printDbg("CP == stacks, should use finisher")
                shouldUseFinisher = true
            end
        end
    end

    if power < 50 and amstlib.CONST.SPELL_KNOWN.bladeRush and GMR.IsCastable(amstlib.CONST.SPELL.bladeRush, "target") then
        self.cr:printDbg("should cast blade rush to generate power")
        GMR.Cast(amstlib.CONST.SPELL.bladeRush, "target")
        return
    end

    if power < 50 and amstlib.CONST.SPELL_KNOWN.adrenalineRush and GMR.IsCastable(amstlib.CONST.SPELL.adrenalineRush, "player") then
        self.cr:printDbg("should cast adrenaline rush")
        GMR.Cast(amstlib.CONST.SPELL.adrenalineRush, "player")
        return
    end

    if GMR.GetHealth("player") <= 80 and GMR.IsCastable(amstlib.CONST.SPELL.crimsonVial, "player") then
        self.cr:printDbg("should cast crimson vial to heal")
        GMR.Cast(amstlib.CONST.SPELL.crimsonVial, "player")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.rollTheBones and GMR.IsCastable(amstlib.CONST.SPELL.rollTheBones, "player") then
        local shouldCast = true
        if rollTheBonesBuffCount >= 3 then
            shouldCast = false
        elseif rollTheBonesBuffCount == 2 and (rollTheBonesHasBroadside or rollTheBonesHasTrueBearing) then
            shouldCast = false
        end

        if shouldCast then
            self.cr:printDbg("should cast roll the bones")
            GMR.Cast(amstlib.CONST.SPELL.rollTheBones, "player")
            return
        end
    end

    if self.trinketer:useTrinkets() then
        return
    end

    --for i = 1, #GMR.Tables.Attackables do
    --    local attackable = GMR.Tables.Attackables[i][1]
    --    if GMR.ObjectExists(attackable) and GMR.GetDistance("player", attackable, "<", 30) then
    --        local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = GMR.UnitCastingInfo(attackable)
    --        if name then
    --            if not notInterruptible then
    --                self.cr:printDbg("someone casting spell '" .. name .. "':'" .. spellId .. "'", 2)
    --            end
    --        end
    --    end
    --end

    if amstlib.CONST.SPELL_KNOWN.bladeFlurry and GMR.GetNumEnemies("player", 10) >= 2
        and GMR.IsCastable(amstlib.CONST.SPELL.bladeFlurry, "player")
    then
        self.cr:printDbg("should case blade flurry to aoe")
        GMR.Cast(amstlib.CONST.SPELL.bladeFlurry, "player")
        return
    end

    if not shouldUseFinisher and amstlib.CONST.SPELL_KNOWN.echoingReprimand
        and comboPoints + echoingReprimandCPGen <= comboPointMax
        and IsCastable(amstlib.CONST.SPELL.echoingReprimand, "target")
    then
        self.cr:printDbg("should cast echoing reprimand to generate CP")
        GMR.Cast(amstlib.CONST.SPELL.echoingReprimand, "target")
        return
    end

    if not shouldUseFinisher and GMR.HasBuff("player", amstlib.CONST.BUFF.opportunity, true)
        and amstlib.CONST.SPELL_KNOWN.pistolShot
        and comboPointMax - comboPoints >= 2
        and GMR.IsCastable(amstlib.CONST.SPELL.pistolShot, "target")
    then
        self.cr:printDbg("should cast pistol shot to consume opportunity buff")
        GMR.Cast(amstlib.CONST.SPELL.pistolShot, "target")
        return
    end

    if not shouldUseFinisher and comboPointMax - comboPoints >= 2 and amstlib.CONST.SPELL_KNOWN.sinisterStrike
        and IsCastable(amstlib.CONST.SPELL.sinisterStrike, "target")
    then
        self.cr:printDbg("should cast sinister strike to generate CP")
        GMR.Cast(amstlib.CONST.SPELL.sinisterStrike, "target")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.sliceAndDice and comboPoints >= comboPointsMinToSpend
        and GMR.GetBuffExpiration("player", amstlib.CONST.BUFF.sliceAndDice, true) < 8
        and GMR.IsCastable(amstlib.CONST.SPELL.sliceAndDice, "player")
    then
        self.cr:printDbg("should cast slice and dice to buff yourself")
        GMR.Cast(amstlib.CONST.SPELL.sliceAndDice, "target")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.betweenTheEyes and shouldUseFinisher
        and GMR.IsCastable(amstlib.CONST.SPELL.betweenTheEyes, "target")
    then
        self.cr:printDbg("should cast between the eyes to consume CP")
        GMR.Cast(amstlib.CONST.SPELL.betweenTheEyes, "target")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.dispatch and shouldUseFinisher
        and IsCastable(amstlib.CONST.SPELL.dispatch, "target")
    then
        self.cr:printDbg("should cast dispatch to consume CP")
        GMR.Cast(amstlib.CONST.SPELL.dispatch, "target")
        return
    end
end

---@return boolean
function Rotation:isSilent()
    return false
end

---@return boolean
function Rotation:isStunned()
    --if GMR.HasDebuff("player", debuffs.hammerOfJustice) then
    --    return true
    --end

    return false
end

do
    local ok, err = pcall(function()
        local cr = amstlib:getCombatRotation(ID)
        cr:initialize(
            VERSION,
            function()
                return GMR.GetClass("player") == "ROGUE"
            end,
            function()
                local cfg = Config:new(cr)
                cfg:apply(cr:getConfig())

                local state = State:new()
                state:determine(cfg)

                local trinketer = AmstLibTrinketer:new(cr)
                trinketer:initialize(amstlib.CONST.SPELL.doorOfShadows)

                local rotation = Rotation:new(cfg, state, cr, trinketer)
                return function()
                    rotation:execute()
                end
            end
        )
    end)
    if not ok then
        GMR.Print(ID .. "[ERROR] " .. err)
    end

end