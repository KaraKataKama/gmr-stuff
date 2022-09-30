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

local ID = "CR>DH/H"
local VERSION = "v1.0.0"

---@class DemonHunterConfig
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = false,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = false,
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
---@return DemonHunterConfig
function Config:new(cr)
    local o = {
        cr = cr,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Apply object to change default values
---@param object DemonHunterConfig another config
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

---@class DemonHunterState
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
---@param cfg DemonHunterConfig config
---@return void
function State:determine(cfg)
end

---@class DemonHunterRotation
local Rotation = {
    ---@type DemonHunterConfig
    cfg = nil,
    ---@type DemonHunterState
    state = nil,
    ---@type AmstLibCombatRotation
    cr = nil,
    ---@type AmstLibTrinketer
    trinketer = nil
}
---@param cfg PaladinConfig
---@param state PaladinState
---@param cr AmstLibCombatRotation
---@param trinketer AmstLibTrinketer
---@return DemonHunterRotation
function Rotation:new(cfg, state, cr, trinketer)
    ---@type DemonHunterRotation
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

    local spellToCheckGCD = amstlib.CONST.SPELL.doorOfShadows

    --local isTargetAttackable = GMR.IsAlive("target") and GMR.UnitCanAttack("player", "target")
    --    and not GMR.IsImmune("target")
    local isTargetAttackable = true

    local power = GMR.UnitPower("player")
    local powerMax = GMR.UnitPowerMax("player")
    local demonsBitePowerGen = 40
    local eyeBeamCost = 30
    local useDemonBiteMaxPower = powerMax - demonsBitePowerGen
    local chaosStrikePowerCost = 40
    local shouldCastAdditionalSpells = true
    if GMR.HasBuff("player", amstlib.CONST.BUFF.metamorphosis) and GMR.GetBuffExpiration("player", amstlib.CONST.BUFF.metamorphosis) < 8 then
        shouldCastAdditionalSpells = false
    end

    local bladeDanceLikeSpell = amstlib.CONST.SPELL.bladeDance
    if GMR.IsSpellKnown(amstlib.CONST.SPELL.deathSweep) then
        bladeDanceLikeSpell = amstlib.CONST.SPELL.deathSweep
    end

    local eyeBeamStartCooldown, eyeBeamDuration = GetSpellCooldown(amstlib.CONST.SPELL.eyeBeam)
    local durationLeft = eyeBeamDuration - (GetTime() - eyeBeamStartCooldown)
    if power > eyeBeamCost then
        local shouldCastSinfulBrand = amstlib.CONST.SPELL_KNOWN.sinfulBrand and GMR.IsCastable(amstlib.CONST.SPELL.sinfulBrand, "target")
            and not GMR.HasBuff("target", amstlib.CONST.DEBUFF.sinfulBrand, true)
        if (durationLeft <= 0.1 or (durationLeft <= 1 and shouldCastSinfulBrand)) then
            if shouldCastSinfulBrand then
                self.cr:printDbg("should sinful brand before eye beam")
                GMR.Cast(amstlib.CONST.SPELL.sinfulBrand, "target")
                return
            end
            if GMR.IsCastable(amstlib.CONST.SPELL.eyeBeam, "target") and not GMR.IsMoving() then
                self.cr:printDbg("should cast eye beam")
                GMR.Cast(amstlib.CONST.SPELL.eyeBeam, "target")
                return
            end
        end

    end

    if isTargetAttackable and shouldCastAdditionalSpells and power < powerMax - 40
        and GMR.IsCastable(amstlib.CONST.SPELL.immolationAura, "player")
        and GMR.GetNumEnemies("player", 15) >= 1
    then
        self.cr:printDbg("should cast immolation aura")
        GMR.Cast(amstlib.CONST.SPELL.immolationAura, "player")
        return
    end

    if GMR.GetNumEnemies("player", 10) >= 3 and GMR.IsCastable(bladeDanceLikeSpell, "player") then
        self.cr:printDbg("should use blade dance like spell '" .. bladeDanceLikeSpell .. "'for aoe")
        GMR.Cast(bladeDanceLikeSpell, "player")
        return
    end

    if amstlib.CONST.SPELL_KNOWN.glaiveTempest and shouldCastAdditionalSpells
        and GMR.GetNumEnemies("player", 10) >= 2
        and GMR.IsCastable(amstlib.CONST.SPELL.glaiveTempest, "player")
    then
        self.cr:printDbg("should use glaive tempest for aoe")
        GMR.Cast(amstlib.CONST.SPELL.glaiveTempest, "player")
        return
    end

    if self.trinketer:useTrinkets() then
        return
    end

    if isTargetAttackable and power <= useDemonBiteMaxPower and GMR.IsCastable(amstlib.CONST.SPELL.demonsBite, "target") then
        self.cr:printDbg("should cast demon's bite to generate power")
        GMR.Cast(amstlib.CONST.SPELL.demonsBite, "target")
        return
    end

    local chaosStrikeLikeSpell = amstlib.CONST.SPELL.chaosStrike
    if GMR.IsSpellKnown(amstlib.CONST.SPELL.annihilation) then
        chaosStrikeLikeSpell = amstlib.CONST.SPELL.annihilation
    end

    local isChaosStrikeLikeSpellCastable = GMR.IsCastable(chaosStrikeLikeSpell, "target")
    if chaosStrikeLikeSpell == amstlib.CONST.SPELL.annihilation then
        -- bug with IsCastable of Annihilation
        isChaosStrikeLikeSpellCastable = GMR.IsCastable(amstlib.CONST.SPELL.demonsBite, "target")
    end
    if isTargetAttackable and power >= useDemonBiteMaxPower and isChaosStrikeLikeSpellCastable then
        self.cr:printDbg("should cast chaos strike like spell '" .. chaosStrikeLikeSpell .. "' to consume power")
        GMR.Cast(chaosStrikeLikeSpell, "target")
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
                return GMR.GetClass("player") == "DEMONHUNTER"
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