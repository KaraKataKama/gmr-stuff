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

---@class DruidFeralV1Config
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
---@return DruidFeralV1Config
function Config:new(cr)
    local o = {
        cr = cr,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Apply object to change default values
---@param object DruidFeralV1Config another config
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

---@class DruidFeralV1State
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
---@param cfg DruidFeralV1Config config
---@return void
function State:determine(cr, cfg)
end

---@class DruidFeralV1Rotation
local Rotation = {
    ---@type DruidFeralV1Config
    cfg = nil,
    ---@type DruidFeralV1State
    state = nil,
    ---@type AmstLibCombatRotation
    cr = nil,
    ---@type AmstLibTrinketer
    trinketer = nil,
}
---@param cfg DruidFeralV1Config
---@param state DruidFeralV1State
---@param cr AmstLibCombatRotation
---@param trinketer AmstLibTrinketer
---@return DruidFeralV1Rotation
function Rotation:new(cfg, state, cr, trinketer)
    ---@type DruidFeralV1Rotation
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

local function GetDebuffExpiration(unit, debuff, byPlayer)
    local spellName, expiration, owner
    local byPlayer = byPlayer or false
    for i = 1, 40 do
        spellName, _, _, _, _, expiration, owner = GMR.UnitDebuff(unit, i)
        if spellName and spellName == debuff and (not byPlayer or (byPlayer and owner == "player")) then
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
                return GMR.GetClass("player") == amstlib.CONST.CLASS.DRUID
                    -- and select(5, GetTalentInfo(2, 8)) == 1 TODO: determine proper talents for feral druid
            end,
            function()
                local cfg = Config:new(cr)
                cfg:apply(cr:getConfig())

                local state = State:new()
                state:determine(cr, cfg)

                local trinketer = AmstLibTrinketer:new(cr)
                --trinketer:initialize(amstlib.CONST.SPELL.chainsOfIce) TODO: determine proper spell to gcd check, of find another way

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