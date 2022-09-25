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
local VERSION = "v1.4.0"

---@class DruidConfig
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = false,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = false,
    ---Use online loading feature to get last updates
    onlineLoad = true,

    ---@type AmstLibCombatRotation
    cr = nil
}

---@param cr AmstLibCombatRotation
---@return DruidConfig
function Config:new(cr)
    local o = {
        cr = cr,
    }
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
            self.cr:print("Unknown config key '" .. tostring(k) .. "', skip.")
        elseif self[k] ~= v then
            self.cr:print("Option '" .. tostring(k) .. "' changed from '" .. tostring(self[k]) .. "' to '" .. tostring(v) .. "'.")
            self[k] = v
        end
    end
end

---@class DruidState
local State = {
}

function State:new()
    local o = { }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Determine state
---@param cfg DruidConfig config
---@return void
function State:determine(cfg)
end

---@class DruidRotation
local Rotation = {
    ---@type DruidConfig
    cfg = nil,
    ---@type DruidState
    state = nil,
    ---@type AmstLibCombatRotation
    cr = nil,
}
---@param cfg PaladinConfig
---@param state PaladinState
---@param cr AmstLibCombatRotation
---@return DruidRotation
function Rotation:new(cfg, state, cr)

    ---@type DruidRotation
    local o = {
        cfg = cfg,
        state = state,
        cr = cr,
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
        return
    end

    local isTargetAttackable = GMR.IsAlive("target") and GMR.UnitCanAttack("player", "target")
        and not GMR.IsImmune("target")

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
        local cr = amstlib:getCombatRotation("CR>D/F")
        cr:initialize(
            VERSION,
            function()
                return GMR.GetClass("player") == "DRUID"
            end,
            function()
                local cfg = Config:new(cr)
                cfg:apply(cr:getConfig())

                local state = State:new()
                state:determine(cfg)

                local rotation = Rotation:new(cfg, state)
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