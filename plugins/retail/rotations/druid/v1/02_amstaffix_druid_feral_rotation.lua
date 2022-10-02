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

local ID = "CR>D/F"
local VERSION = "v1.0.0"

local IsCastable = amstlib.createIsCastableFunc(amstlib.CONST.SPELL.kick)

---@class DruidFeralConfig
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
---@return DruidFeralConfig
function Config:new(cr)
    local o = {
        cr = cr,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Apply object to change default values
---@param object DruidFeralConfig another config
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

---@class DruidFeralState
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
---@param cfg DruidFeralConfig config
---@return void
function State:determine(cfg)
end

---@class DruidFeralRotation
local Rotation = {
    ---@type DruidFeralConfig
    cfg = nil,
    ---@type DruidFeralState
    state = nil,
    ---@type AmstLibCombatRotation
    cr = nil,
    ---@type AmstLibTrinketer
    trinketer = nil,
}
---@param cfg DruidFeralConfig
---@param state DruidFeralState
---@param cr AmstLibCombatRotation
---@param trinketer AmstLibTrinketer
---@return DruidFeralRotation
function Rotation:new(cfg, state, cr, trinketer)
    ---@type DruidFeralRotation
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
    local shouldUseFinisher = false
    if comboPoints >= 4 then
        shouldUseFinisher = true
    end

    if GMR.HasBuff("player", amstlib.CONST.BUFF.predatorySwiftness, true) then
        self.cr:printDbg("should cast regrowth to consume predatory swiftness buff")
        GMR.Cast(amstlib.CONST.SPELL.regrowth, "player")
        return
    end

    local isTargetAttackable = GMR.IsAlive("target") and GMR.UnitCanAttack("player", "target")
        and not GMR.IsImmune("target")

    if isTargetAttackable and not GMR.HasBuff("player", amstlib.CONST.BUFF.catForm, true)
        and amstlib.CONST.SPELL_KNOWN.catForm and GMR.IsCastable(amstlib.CONST.SPELL.catForm, "player")
    then
        self.cr:printDbg("should cast cat form to start rotation")
        GMR.Cast(amstlib.CONST.SPELL.catForm, "player")
        return
    end

    if not GMR.UnitAffectingCombat("player") and not GMR.HasBuff("player", amstlib.CONST.BUFF.prowl, true)
        and amstlib.CONST.SPELL_KNOWN.prowl and GMR.IsCastable(amstlib.CONST.SPELL.prowl)
    then
        self.cr:printDbg("should cast prowl to make myself invisible")
        GMR.Cast(amstlib.CONST.SPELL.prowl, "player")
    end

    if powerMax - power >= 50 and amstlib.CONST.SPELL_KNOWN.tigersFury and GMR.IsCastable(amstlib.CONST.SPELL.tigersFury, "player")
    then
        self.cr:printDbg("should cast tiger's fury to get buff")
        GMR.Cast(amstlib.CONST.SPELL.tigersFury, "player")
        return
    end

    if isTargetAttackable and GMR.GetDistance("player", "target", ">", 10)
        and GMR.IsSpellKnown(amstlib.CONST.SPELL.wildCharge) and GMR.IsCastable(amstlib.CONST.SPELL.wildCharge, "target")
    then
        self.cr:printDbg("should cast wild charge to shorten the distance")
        GMR.Cast(amstlib.CONST.SPELL.wildCharge, "target")
        return
    end

    if not shouldUseFinisher and isTargetAttackable then
        if not GMR.HasDebuff("target", amstlib.CONST.DEBUFF.rake, true)
            and amstlib.CONST.SPELL_KNOWN.rake and GMR.IsCastable(amstlib.CONST.SPELL.rake, "target")
        then
            self.cr:printDbg("should cast rake to apply debuff")
            GMR.Cast(amstlib.CONST.SPELL.rake, "target")
            return
        end

        for i = 1, #GMR.Tables.Attackables do
            local attackable = GMR.Tables.Attackables[i][1]
            if GMR.ObjectExists(attackable) and GMR.UnitLevel(attackable) > 1
                and GMR.GetDistance("player", attackable, "<", 6)
            then
                if not GMR.HasDebuff(attackable, amstlib.CONST.DEBUFF.rake, true)
                    and amstlib.CONST.SPELL_KNOWN.rake and GMR.IsCastable(amstlib.CONST.SPELL.rake, attackable)
                    and GMR.ObjectIsFacing("player", attackable)
                then
                    self.cr:printDbg("should cast rake to spread debuff on another monster")
                    GMR.Cast(amstlib.CONST.SPELL.rake, attackable)
                    return
                end
            end
        end

        if GMR.GetNumEnemies("player", 10) >= 2 then
            if not GMR.HasDebuff("target", amstlib.CONST.DEBUFF.thrash, true)
                and amstlib.CONST.SPELL_KNOWN.thrash and GMR.IsCastable(amstlib.CONST.SPELL.thrash, "target")
            then
                self.cr:printDbg("should cast thrash to apply debuff")
                GMR.Cast(amstlib.CONST.SPELL.thrash, "target")
                return
            end

            if amstlib.CONST.SPELL_KNOWN.swipe and GMR.IsCastable(amstlib.CONST.SPELL.swipe, "target") then
                self.cr:printDbg("should cast shred to generate CP")
                GMR.Cast(amstlib.CONST.SPELL.swipe, "target")
                return
            end
        else
            if amstlib.CONST.SPELL_KNOWN.shred and GMR.IsCastable(amstlib.CONST.SPELL.shred, "target") then
                self.cr:printDbg("should cast shred to generate CP")
                GMR.Cast(amstlib.CONST.SPELL.shred, "target")
                return
            end
        end
    end

    if shouldUseFinisher and isTargetAttackable then
        if GMR.GetNumEnemies("player", 10) >= 2 then
            if not GMR.HasDebuff("target", amstlib.CONST.DEBUFF.rip, true) and amstlib.CONST.SPELL_KNOWN.primalWrath
                and GMR.IsCastable(amstlib.CONST.SPELL.primalWrath, "target")
            then
                self.cr:printDbg("should cast primal wrath to consume CP and apply debuff")
                GMR.Cast(amstlib.CONST.SPELL.primalWrath, "target")
                return
            end
        else
            if not GMR.HasDebuff("target", amstlib.CONST.DEBUFF.rip, true) and amstlib.CONST.SPELL_KNOWN.rip
                and GMR.IsCastable(amstlib.CONST.SPELL.rip, "target")
            then
                self.cr:printDbg("should cast rip to consume CP and apply debuff")
                GMR.Cast(amstlib.CONST.SPELL.rip, "target")
                return
            end
        end

        if amstlib.CONST.SPELL_KNOWN.ferociousBite and GMR.IsCastable(amstlib.CONST.SPELL.ferociousBite, "target") then
            self.cr:printDbg("should cast ferocious bite to consume CP")
            GMR.Cast(amstlib.CONST.SPELL.ferociousBite, "target")
            return
        end
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
                return GMR.GetClass("player") == "DRUID" and GetSpecialization() == 2
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