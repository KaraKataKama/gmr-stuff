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

local ID = "CR>D/B"
local VERSION = "v1.0.0"

local IsCastable = amstlib.createIsCastableFunc(amstlib.CONST.SPELL.kick)

---@class DruidBalanceConfig
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
---@return DruidBalanceConfig
function Config:new(cr)
    local o = {
        cr = cr,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Apply object to change default values
---@param object DruidBalanceConfig another config
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

---@class DruidBalanceState
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
---@param cfg DruidBalanceConfig config
---@return void
function State:determine(cfg)
end

---@class DruidBalanceRotation
local Rotation = {
    ---@type DruidBalanceConfig
    cfg = nil,
    ---@type DruidBalanceState
    state = nil,
    ---@type AmstLibCombatRotation
    cr = nil,
    ---@type AmstLibTrinketer
    trinketer = nil,
}
---@param cfg DruidBalanceConfig
---@param state DruidBalanceState
---@param cr AmstLibCombatRotation
---@param trinketer AmstLibTrinketer
---@return DruidBalanceRotation
function Rotation:new(cfg, state, cr, trinketer)
    ---@type DruidBalanceRotation
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

    local isAoe = GMR.GetNumEnemies("target", 10) > 1

    if GMR.GetDebuffExpiration("target", amstlib.CONST.DEBUFF.moonfire, true) < 5
        and GMR.IsCastable(amstlib.CONST.SPELL.moonfire, "target")
    then
        self.cr:printDbg("should cast moonfire to apply debuff")
        GMR.Cast(amstlib.CONST.SPELL.moonfire, "target")
        return
    end

    if GMR.GetDebuffExpiration("target", amstlib.CONST.RETAIL.DEBUFF.sunfire, true) < 5
        and GMR.IsCastable(amstlib.CONST.RETAIL.SPELL.sunfire, "target")
    then
        self.cr:printDbg("should cast sunfire to apply debuff")
        GMR.Cast(amstlib.CONST.RETAIL.SPELL.sunfire, "target")
        return
    end

    if GMR.GetNumEnemies("target", 10) > 1 and amstlib.CONST.RETAIL.SPELL_KNOWN.starfall
        and GMR.IsCastable(amstlib.CONST.RETAIL.SPELL.starfall, "player")
    then
        self.cr:printDbg("should cast starfall to make aoe")
        GMR.Cast(amstlib.CONST.RETAIL.SPELL.starfall, "player")
        return
    end

    if amstlib.CONST.RETAIL.SPELL_KNOWN.furyOfElune and GMR.IsCastable(amstlib.CONST.RETAIL.SPELL.furyOfElune, "target") then
        if isAoe then
            if GMR.HasBuff("player", amstlib.CONST.RETAIL.BUFF.eclipseLunar) then
                self.cr:printDbg("should cast fury of elune to generate more power")
                GMR.Cast(amstlib.CONST.RETAIL.SPELL.furyOfElune, "target")
                return
            end
        else
            if GMR.HasBuff("player", amstlib.CONST.RETAIL.BUFF.eclipseSolar) then
                self.cr:printDbg("should cast fury of elune to generate more power")
                GMR.Cast(amstlib.CONST.RETAIL.SPELL.furyOfElune, "target")
                return
            end
        end
    end

    if (GMR.HasBuff("player", amstlib.CONST.RETAIL.BUFF.eclipseLunar) or GMR.HasBuff("player", amstlib.CONST.RETAIL.BUFF.eclipseSolar))
        and power >= 88 and amstlib.CONST.RETAIL.SPELL_KNOWN.starsurge and GMR.IsCastable(amstlib.CONST.RETAIL.SPELL.starsurge, "target")
    then
        self.cr:printDbg("should cast starsurge to consume power")
        GMR.Cast(amstlib.CONST.RETAIL.SPELL.starsurge, "target")
        return
    end

    if GMR.HasBuff("player", amstlib.CONST.RETAIL.BUFF.eclipseLunar) and amstlib.CONST.RETAIL.SPELL_KNOWN.starfire
        and GMR.IsCastable(amstlib.CONST.RETAIL.SPELL.starfire, "target")
    then
        self.cr:printDbg("should cast starfire because of lunar-eclipe")
        GMR.Cast(amstlib.CONST.RETAIL.SPELL.starfire, "target")
        return
    end

    if isAoe and GMR.HasBuff("player", amstlib.CONST.RETAIL.BUFF.eclipseSolar) then
        for i = 1, #GMR.Tables.Attackables do
            local attackable = GMR.Tables.Attackables[i][1]
            if GMR.ObjectExists(attackable) and GMR.UnitLevel(attackable) > 1
                and GMR.GetDistance("target", attackable, "<", 20)
            then
                if GMR.GetDebuffExpiration(attackable, amstlib.CONST.DEBUFF.moonfire, true) < 5
                    and amstlib.CONST.SPELL_KNOWN.moonfire and GMR.IsCastable(amstlib.CONST.SPELL.moonfire, attackable)
                    and GMR.ObjectIsFacing("player", attackable)
                then
                    self.cr:printDbg("should cast moonfire to spread DoT")
                    GMR.Cast(amstlib.CONST.SPELL.moonfire, attackable)
                    return
                end
            end
        end
    end

    if GMR.HasBuff("player", amstlib.CONST.RETAIL.BUFF.eclipseSolar) and amstlib.CONST.SPELL_KNOWN.wrath
        and GMR.IsCastable(amstlib.CONST.SPELL.wrath, "target")
    then
        self.cr:printDbg("should cast wrath because of solar-eclipe")
        GMR.Cast(amstlib.CONST.SPELL.wrath, "target")
        return
    end

    if GetSpellCount(amstlib.CONST.RETAIL.SPELL.starfire) > 0 and amstlib.CONST.RETAIL.SPELL_KNOWN.starfire
        and GMR.IsCastable(amstlib.CONST.RETAIL.SPELL.starfire, "target")
    then
        self.cr:printDbg("should cast starfire to consume spell counter")
        GMR.Cast(amstlib.CONST.RETAIL.SPELL.starfire, "target")
        return
    end

    if GetSpellCount(amstlib.CONST.SPELL.wrath) > 0 and amstlib.CONST.SPELL_KNOWN.wrath
        and GMR.IsCastable(amstlib.CONST.SPELL.wrath, "target")
    then
        self.cr:printDbg("should cast wrath to consume spell counter")
        GMR.Cast(amstlib.CONST.SPELL.wrath, "target")
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
                return GMR.GetClass("player") == "DRUID" and GetSpecialization() == 1
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