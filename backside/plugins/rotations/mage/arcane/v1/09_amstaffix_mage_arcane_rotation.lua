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

local ID = "CR>M/A"
local VERSION = "v1.0.0"

---@class MageArcaneV1Config
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

    useTrinket1 = false,
    useTrinket1Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful

    useTrinket2 = false,
    useTrinket2Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful

    ---@type AmstLibCombatRotation
    cr = nil
}

---@param cr AmstLibCombatRotation
---@return MageArcaneV1Config
function Config:new(cr)
    local o = {
        cr = cr,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Apply object to change default values
---@param object MageArcaneV1Config another config
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

---@class MageArcaneV1State
local State = {
}

function State:new()
    local o = { }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Determine state
---@param cr AmstLibCombatRotation
---@param cfg MageArcaneV1Config config
---@return void
function State:determine(cr, cfg)

end

---@class MageArcaneV1Rotation
local Rotation = {
    ---@type MageArcaneV1Config
    cfg = nil,
    ---@type MageArcaneV1State
    state = nil,
    ---@type AmstLibCombatRotation
    cr = nil,
    ---@type AmstLibTrinketer
    trinketer = nil,
}
---@param cfg MageArcaneV1Config
---@param state MageArcaneV1State
---@param cr AmstLibCombatRotation
---@param trinketer AmstLibTrinketer
---@return MageArcaneV1Rotation
function Rotation:new(cfg, state, cr, trinketer)
    ---@type MageArcaneV1Rotation
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

    if self.trinketer:useTrinkets() then
        return
    end

    if GMR.HasBuff("player", amstlib.CONST.BUFF.presenceOfMind)
        and GMR.IsCastable(amstlib.CONST.SPELL.fireball, "target")
    then
        self.cr:printDbg("should cast fireball to consume presence of mind buff")
        GMR.Cast(amstlib.CONST.SPELL.fireball, "target")
        return
    end

    if GMR.HasBuff("player", amstlib.CONST.BUFF.missileBarrage) and not GMR.IsMoving()
        and GMR.IsCastable(amstlib.CONST.SPELL.arcaneMissiles, "target")
    then
        self.cr:printDbg("should cast arcane missiles to consume middle barrage buff")
        GMR.Cast(amstlib.CONST.SPELL.arcaneMissiles, "target")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.arcaneBarrage and GMR.IsCastable(amstlib.CONST.SPELL.arcaneBarrage, "target") then
        self.cr:printDbg("should cast arcane barrage")
        GMR.Cast(amstlib.CONST.SPELL.arcaneBarrage, "target")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.fireBlast and GMR.IsCastable(amstlib.CONST.SPELL.fireBlast, "target") then
        self.cr:printDbg("should cast fire blast")
        GMR.Cast(amstlib.CONST.SPELL.fireBlast, "target")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.coneOfCold and GMR.IsCastable(amstlib.CONST.SPELL.coneOfCold, "target") then
        self.cr:printDbg("should cast cone of cold")
        GMR.Cast(amstlib.CONST.SPELL.coneOfCold, "target")
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
                if GMR.GetClass("player") ~= amstlib.CONST.CLASS.MAGE then
                    return false
                end

                local playerName = GMR.UnitName("player")
                for _, name in ipairs(cr:getConfig()["forceLoadForCharacters"] or {}) do
                    if playerName == name then
                        return true
                    end
                end

                return amstlib.Util.getDeepestTalentTab() == 1
            end,
            function()
                local cfg = Config:new(cr)
                cfg:apply(cr:getConfig())

                local state = State:new()
                state:determine(cr, cfg)

                local trinketer = AmstLibTrinketer:new(cr)
                --trinketer:initialize(amstlib.CONST.SPELL.chainsOfIce)

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