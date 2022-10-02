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

local ID = "CR>D/G"
local VERSION = "v1.0.0"

local IsCastable = amstlib.createIsCastableFunc(amstlib.CONST.SPELL.kick)

---@class DruidGuardianConfig
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
---@return DruidGuardianConfig
function Config:new(cr)
    local o = {
        cr = cr,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Apply object to change default values
---@param object DruidGuardianConfig another config
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

---@class DruidGuardianState
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
---@param cfg DruidGuardianConfig config
---@return void
function State:determine(cfg)
end

---@class DruidGuardianRotation
local Rotation = {
    ---@type DruidGuardianConfig
    cfg = nil,
    ---@type DruidGuardianState
    state = nil,
    ---@type AmstLibCombatRotation
    cr = nil,
    ---@type AmstLibTrinketer
    trinketer = nil,
}
---@param cfg DruidGuardianConfig
---@param state DruidGuardianState
---@param cr AmstLibCombatRotation
---@param trinketer AmstLibTrinketer
---@return DruidGuardianRotation
function Rotation:new(cfg, state, cr, trinketer)
    ---@type DruidGuardianRotation
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

    local isTargetAttackable = GMR.IsAlive("target") and GMR.UnitCanAttack("player", "target")
        and not GMR.IsImmune("target")

    if not GMR.HasBuff("player", amstlib.CONST.BUFF.bearForm) and amstlib.CONST.SPELL_KNOWN.bearForm
        and GMR.IsCastable(amstlib.CONST.SPELL.bearForm, "player")
    then
        self.cr:printDbg("should cast bear form, because it is not active")
        GMR.Cast(amstlib.CONST.SPELL.bearForm, "player")
        return
    end

    if isTargetAttackable and amstlib.CONST.SPELL_KNOWN.ironfur and GMR.IsCastable(amstlib.CONST.SPELL.ironfur, "player") then
        self.cr:printDbg("should cast ironfur to consume rage")
        GMR.Cast(amstlib.CONST.SPELL.ironfur, "player")
        return
    end

    if isTargetAttackable and GMR.GetHealth("player") < 90 and amstlib.CONST.SPELL_KNOWN.bristlingFur
        and GMR.IsCastable(amstlib.CONST.SPELL.bristlingFur, "player")
    then
        self.cr:printDbg("should cast bristling fur to defend")
        GMR.Cast(amstlib.CONST.SPELL.bristlingFur, "player")
        return
    end

    if GMR.GetHealth("player") < 70 and amstlib.CONST.SPELL_KNOWN.frenziedRegeneration
        and GMR.IsCastable(amstlib.CONST.SPELL.frenziedRegeneration, "player")
        and not GMR.HasBuff("player", amstlib.CONST.BUFF.frenziedRegeneration, true)
    then
        self.cr:printDbg("should cast frenzied regeneration to heal")
        GMR.Cast(amstlib.CONST.SPELL.frenziedRegeneration, "player")
        return
    end

    if isTargetAttackable then
        for i = 1, #GMR.Tables.Attackables do
            local attackable = GMR.Tables.Attackables[i][1]
            local targetOfAttackable = GMR.UnitTarget(attackable)
            if GMR.ObjectExists(attackable) and GMR.UnitLevel(attackable) > 1
                and not GMR.UnitIsUnit(targetOfAttackable, "player")
                and GMR.GetDistance("player", attackable, "<", 40)
                and GMR.GetDistance("player", attackable, ">", 15)
            then
                self.cr:printDbg("attackable '" .. GMR.UnitName(attackable) .. "'")
                if amstlib.CONST.SPELL_KNOWN.moonfire and GMR.IsCastable(amstlib.CONST.SPELL.moonfire, attackable) then
                    self.cr:printDbg("should cast moonfire on attackable '" .. GMR.UnitName(attackable) .. "' to taunt")
                    GMR.Cast(amstlib.CONST.SPELL.moonfire, attackable)
                    return
                end
            end
        end
    end

    if isTargetAttackable and amstlib.CONST.SPELL_KNOWN.mangle and GMR.IsCastable(amstlib.CONST.SPELL.mangle, "target") then
        self.cr:printDbg("should cast mangle on cd")
        GMR.Cast(amstlib.CONST.SPELL.mangle, "target")
        return
    end

    if isTargetAttackable and amstlib.CONST.SPELL_KNOWN.thrash and GMR.IsCastable(amstlib.CONST.SPELL.thrash, "target") then
        self.cr:printDbg("should cast mangle on cd")
        GMR.Cast(amstlib.CONST.SPELL.thrash, "target")
        return
    end

    if isTargetAttackable and amstlib.CONST.SPELL_KNOWN.swipe and GMR.IsCastable(amstlib.CONST.SPELL.swipe, "target") then
        self.cr:printDbg("should cast swipe as a filler")
        GMR.Cast(amstlib.CONST.SPELL.swipe, "target")
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
                return GMR.GetClass("player") == "DRUID" and GetSpecialization() == 3
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