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

---@class AmstLib
amstlib = {}
---@type table<string, AmstLibCombatRotation>
amstlib.combatRotations = {}

amstlib.CONST = {}
amstlib.CONST.SPELL = {
    exorcism = GetSpellInfo(5614),
    flashOfLight = GetSpellInfo(19939),
    hammerOfWrath = GetSpellInfo(24275),
    handOfReckoning = GetSpellInfo(62124),
    purify = GetSpellInfo(1152),
    cleanse = GetSpellInfo(4987),
    crusaderStrike = GetSpellInfo(35395),
    consecrations = GetSpellInfo(20116),
    divineStorm = GetSpellInfo(53385),
    judgementOfLight = GetSpellInfo(20271),
    judgementOfWisdom = GetSpellInfo(53408),
    judgementOfJustice = GetSpellInfo(53407),
    devotionAura = GetSpellInfo(10293),
    retributionAura = GetSpellInfo(10301),
    concentrationAura = GetSpellInfo(19746),
    crusaderAura = GetSpellInfo(32223),
    blessingOfFreedom = GetSpellInfo(1044),
    blessingOfMight = GetSpellInfo(19837),
    blessingOfKings = GetSpellInfo(20217),
    sealOfRighteousness = GetSpellInfo(21084),
    sealOfJustice = GetSpellInfo(20164),
    sealOfLight = GetSpellInfo(20165),
    sealOfWisdom = GetSpellInfo(20166),
    sealOfCommand = GetSpellInfo(20375),
    greaterBlessingOfMight = GetSpellInfo(25916),
    greaterBlessingOfKings = GetSpellInfo(25898),
    shadowResistanceAura = GetSpellInfo(27151),
    frostResistanceAura = GetSpellInfo(19898),
    divineProtection = GetSpellInfo(498),
    handOfProtection = GetSpellInfo(5599),
    demonsBite = GetSpellInfo(162243),
    chaosStrike = GetSpellInfo(162794),
    immolationAura = GetSpellInfo(258920),
    eyeBeam = GetSpellInfo(198013),
    annihilation = GetSpellInfo(201427),
    deathSweep = GetSpellInfo(210152),
    bladeDance = GetSpellInfo(188499),
    glaiveTempest = GetSpellInfo(342817),
    sinfulBrand = GetSpellInfo(317009),
    doorOfShadows = GetSpellInfo(300728),
    frostBolt = GetSpellInfo(8408),
}
amstlib.CONST.SPELL_KNOWN = {
    exorcism = GMR.IsSpellKnown(amstlib.CONST.SPELL.exorcism),
    flashOfLight = GMR.IsSpellKnown(amstlib.CONST.SPELL.flashOfLight),
    hammerOfWrath = GMR.IsSpellKnown(amstlib.CONST.SPELL.hammerOfWrath),
    handOfReckoning = GMR.IsSpellKnown(amstlib.CONST.SPELL.handOfReckoning),
    purify = GMR.IsSpellKnown(amstlib.CONST.SPELL.purify),
    cleanse = GMR.IsSpellKnown(amstlib.CONST.SPELL.cleanse),
    crusaderStrike = GMR.IsSpellKnown(amstlib.CONST.SPELL.crusaderStrike),
    consecrations = GMR.IsSpellKnown(amstlib.CONST.SPELL.consecrations),
    divineStorm = GMR.IsSpellKnown(amstlib.CONST.SPELL.divineStorm),
    judgementOfLight = GMR.IsSpellKnown(amstlib.CONST.SPELL.judgementOfLight),
    judgementOfWisdom = GMR.IsSpellKnown(amstlib.CONST.SPELL.judgementOfWisdom),
    judgementOfJustice = GMR.IsSpellKnown(amstlib.CONST.SPELL.judgementOfJustice),
    devotionAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.devotionAura),
    retributionAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.retributionAura),
    concentrationAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.concentrationAura),
    crusaderAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.crusaderAura),
    blessingOfFreedom = GMR.IsSpellKnown(amstlib.CONST.SPELL.blessingOfFreedom),
    blessingOfMight = GMR.IsSpellKnown(amstlib.CONST.SPELL.blessingOfMight),
    blessingOfKings = GMR.IsSpellKnown(amstlib.CONST.SPELL.blessingOfKings),
    sealOfRighteousness = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfRighteousness),
    sealOfJustice = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfJustice),
    sealOfLight = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfLight),
    sealOfWisdom = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfWisdom),
    sealOfCommand = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfCommand),
    greaterBlessingOfMight = GMR.IsSpellKnown(amstlib.CONST.SPELL.greaterBlessingOfMight),
    greaterBlessingOfKings = GMR.IsSpellKnown(amstlib.CONST.SPELL.greaterBlessingOfKings),
    shadowResistanceAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.shadowResistanceAura),
    frostResistanceAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.frostResistanceAura),
    divineProtection = GMR.IsSpellKnown(amstlib.CONST.SPELL.divineProtection),
    handOfProtection = GMR.IsSpellKnown(amstlib.CONST.SPELL.handOfProtection),
    demonsBite = GMR.IsSpellKnown(amstlib.CONST.SPELL.demonsBite),
    chaosStrike = GMR.IsSpellKnown(amstlib.CONST.SPELL.chaosStrike),
    immolationAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.immolationAura),
    eyeBeam = GMR.IsSpellKnown(amstlib.CONST.SPELL.eyeBeam),
    annihilation = GMR.IsSpellKnown(amstlib.CONST.SPELL.annihilation),
    deathSweep = GMR.IsSpellKnown(amstlib.CONST.SPELL.deathSweep),
    bladeDance = GMR.IsSpellKnown(amstlib.CONST.SPELL.bladeDance),
    glaiveTempest = GMR.IsSpellKnown(amstlib.CONST.SPELL.glaiveTempest),
    sinfulBrand = GMR.IsSpellKnown(amstlib.CONST.SPELL.sinfulBrand),
    doorOfShadows = GMR.IsSpellKnown(amstlib.CONST.SPELL.doorOfShadows),
    frostBolt = GMR.IsSpellKnown(amstlib.CONST.SPELL.frostBolt),
}
amstlib.CONST.BUFF = {
    theArtOfWar = GetSpellInfo(59578),
    blessingOfMight = GetSpellInfo(19837),
    blessingOfKings = GetSpellInfo(20217),
    sealOfRighteousness = GetSpellInfo(21084),
    sealOfJustice = GetSpellInfo(20164),
    sealOfLight = GetSpellInfo(20165),
    sealOfWisdom = GetSpellInfo(20166),
    sealOfCommand = GetSpellInfo(20375),
    greaterBlessingOfMight = GetSpellInfo(25916),
    greaterBlessingOfKings = GetSpellInfo(25898),
    battleShout = GetSpellInfo(2048),
    devotionAura = GetSpellInfo(10293),
    retributionAura = GetSpellInfo(10301),
    concentrationAura = GetSpellInfo(19746),
    crusaderAura = GetSpellInfo(32223),
    shadowResistanceAura = GetSpellInfo(27151),
    frostResistanceAura = GetSpellInfo(19898),
    metamorphosis = GetSpellInfo(162264),
}
amstlib.CONST.DEBUFF = {
    sinfulBrand = GetSpellInfo(317009),
}
amstlib.CONST.INVENTORY = {}
amstlib.CONST.INVENTORY.SLOT_ID = {
    TRINKET_1 = 13,
    TRINKET_2 = 14,
}

amstlib.CONST.CLASS = {
    WARRIOR = "WARRIOR",
    PALADIN = "PALADIN",
    HUNTER = "HUNTER",
    ROGUE = "ROGUE",
    PRIEST = "PRIEST",
    DEATHKNIGHT = "DEATHKNIGHT",
    SHAMAN = "SHAMAN",
    MAGE = "MAGE",
    WARLOCK = "WARLOCK",
    MONK = "MONK",
    DRUID = "DRUID",
    DEMONHUNTER = "DEMONHUNTER",
    EVOKER = "EVOKER",
}

---@class AmstLibCombatRotation
AmstLibCombatRotation = {}
AmstLibCombatRotation.id = ""
AmstLibCombatRotation.state = {
    config = {
        onlineLoad = true,
        debug = false,
        ---@type boolean
        useCombatRotationLauncher = true,
    },
    ---@type boolean
    isPrepared = false,
    ---@type boolean
    isInitialized = false,
    version = "",
    msgPrefix = "[CR]",
}

---@param id string
---@return AmstLibCombatRotation
function AmstLibCombatRotation:new(id)
    local o = { id = id, state = { msgPrefix = "[" .. id .. "]" } }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@param id string
---@return AmstLibCombatRotation
function amstlib:getCombatRotation(id)
    if not self.combatRotations[id] then
        self.combatRotations[id] = AmstLibCombatRotation:new(id)
    end

    return self.combatRotations[id]
end

---@param config table
function AmstLibCombatRotation:validateConfig(config)
    local fields = { "debug", "onlineLoad", "useCombatRotationLauncher" }
    for _, f in ipairs(fields) do
        if config[f] == nil then
            error("there is no '" .. f .. "' field in config")
        end
    end
end
---@param id string
---@param config table
---@return boolean, string result and details
function AmstLibCombatRotation:prepare(config)
    self:validateConfig(config)

    self.state.config = config
    self.state.isPrepared = true
end
---@return boolean
function AmstLibCombatRotation:isPrepared()
    return self.state.isPrepared
end

function AmstLibCombatRotation:isInitialized()
    return self.state.isInitialized
end

---@param msg string
---@return void
function AmstLibCombatRotation:print(msg)
    GMR.Print(self.state.msgPrefix .. " " .. msg)
end

---@param msg string
---@return void
function AmstLibCombatRotation:printDbg(msg)
    if not self.state.config.debug then
        return
    end

    GMR.Print(self.state.msgPrefix .. "[DEBUG] " .. tostring(msg))
end

---@param msg string
---@return void
function AmstLibCombatRotation:printError(msg)
    GMR.Print(self.state.msgPrefix .. "[ERROR] " .. tostring(msg))
end

function AmstLibCombatRotation:getConfig()
    if not self:isPrepared() then
        error("Combat rotation is not prepared")
    end

    return self.state.config
end

---@return boolean, string result and details
function AmstLibCombatRotation:load(link)
    if not self:isPrepared() then
        error("rotation not prepared, should call prepare() func first")
        return
    end

    if self.state.config.onlineLoad then
        GMR.SendHttpRequest({
            Url = link,
            Method = "Get",
            Callback = function(content)
                RunScript(content)
                if not self:isInitialized() then
                    self:printError("Rotation have not loaded properly!")
                    self:printError("Content is: " .. content)
                end
            end
        })
    else
        self:print("Offline loading turned on")
    end
end

---@param version string
---@param checkFunc fun():boolean
---@param rotationCreateFunc fun():void
---@param callAfterLaunch fun():void
function AmstLibCombatRotation:initialize(version, checkFunc, rotationCreateFunc, callAfterLaunch)
    if not version then
        error("version is empty")
    end
    self.state.version = version
    self.state.msgPrefix = "[" .. self.id .. "|" .. version .. "]"

    if not checkFunc() then
        return false
    end

    if self.state.isInitialized then
        self:printError("this combat rotation already initialized")
    end
    self.state.isInitialized = true

    self:print("Rotation would be initialized")
    local rotation = rotationCreateFunc()
    local executeRotationFunc = function()
        local isSuccess, err = pcall(rotation)
        if not isSuccess then
            self:printError("Can't launch rotation: " .. err)
        end
    end

    if self.state.config.useCombatRotationLauncher then
        local resultFunction
        if GMR.CustomCombatConditions == nil then
            resultFunction = executeRotationFunc
        else
            self:print("There is another combat conditions, it will be merged with this rotation")
            local oldCombatConditions = GMR.CustomCombatConditions
            resultFunction = function()
                local isSuccess, err = pcall(oldCombatConditions)
                if not isSuccess then
                    self:printError("Can't launch previous custom combat rotation: " .. err)
                end
                executeRotationFunc()
            end
        end

        GMR.CustomCombatConditions = resultFunction
        C_Timer.NewTicker(1, function()
            if GMR.CustomCombatConditions ~= resultFunction then
                GMR.CustomCombatConditions = resultFunction
                self:printError("Something changed GMR.CustomCombatConditions func, it was changed back!")
            end
        end)
    else
        C_Timer.NewTicker(0.1, function()
            if (not GMR.IsExecuting() or not GMR.IsAlive()) then
                return
            end

            if GMR.IsEating("player") or GMR.IsDrinking("player") then
                return
            end

            executeRotationFunc()
        end)
    end

    if callAfterLaunch then
        callAfterLaunch()
    end

    self:print("Rotation fully initialized and turned on.")
    return
end

---@class AmstLibInterrupter
AmstLibInterrupter = {
    ---@type string[]
    priority1List = {},
    ---@type string[]
    priority2List = {},

}

---@return AmstLibInterrupter
function AmstLibInterrupter:new(priority1List, priority2List)
    local o = { priority1List = priority1List, priority2List = priority2List }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@param unit string|userdata
---@return number @2 - interrupt at all cost, 1 - interrupt with common interrupt spell, 0 - do not interrupt
function AmstLibInterrupter:shouldInterrupt(unit)
    if not amstlib.Util.canInterruptSafely(unit) then
        return 0
    end

    local name = GMR.UnitCastingInfo(unit)
    if not name then
        return 0
    end

    for _, spell in ipairs(self.priority2List) do
        if spell == name then
            return 2
        end
    end

    for _, spell in ipairs(self.priority1List) do
        if spell == name then
            return 1
        end
    end

    return 0
end

---@param distance number
---@return userdata[], userdata[] unitPriority1List, unitPriority2List; 1 - use common interrupt spell, 2 - interrupt at all cost
function AmstLibInterrupter:searchUnitToInterrupt(distance)
    local unitPriority1List = {}
    local unitPriority2List = {}
    for i = 1, #GMR.Tables.Attackables do
        local attackable = GMR.Tables.Attackables[i][1]
        if GMR.ObjectExists(attackable) and GMR.GetDistance("player", attackable, "<", distance) then
            local res = self:shouldInterrupt(attackable)
            if res == 1 then
                table.insert(unitPriority1List, attackable)
            elseif res == 2 then
                table.insert(unitPriority2List, attackable)
            end
        end
    end

    return unitPriority1List, unitPriority2List
end

amstlib.defaultInterrupter = AmstLibInterrupter:new({}, {
    amstlib.CONST.SPELL.frostBolt,
})

amstlib.Util = {}
---@param unit string|userdata
---@return boolean
function amstlib.Util.canInterruptSafely(unit)
    local name, _, _, startTimeMS = GMR.UnitCastingInfo(unit)
    if not name then
        return false
    end

    --- should not cast it instantaneously
    if (GetTime() - startTimeMS / 1000) < math.random(5, 8) / 10 then
        return false
    end

    return true
end

GMR.RunEncryptedScript("Dwmp8SO47wDMnLB/XJotsZJa5KoW8faR2zg83EqLjzRVtrkO/DLLEcFo6KPvGFA+njoS/OpjAHEZl0quNwCeSoGYpfZo/peHfGokp5sFO+lkbWYyDLiT+wNbmcsvnVT04cCB0gjbmb27mXjaKZti7fXg/zCc2p7pKEJyyb/0jyMJIBDfBgwfCYZYhNHlJcQmTAYlGXaH/L1bKKiWVP5vvt8M2ih6LcMfvwI4FL0UlDRHGPgrxxIHcd08YpniWZtYp90BmtWNfm7Dan0OtU7+CIvKoOf8KpLibhboN4j046aBG6TV7ZI99aV1PrYN4ufeCuu0p+QhL/qtE6Ww9LYScpM9XF0uulhbztSylZY+RbGQWt8cpebvwZctFnuN6iB4df1tW4AfBgg+J2F3tgt1j7rlrMNPZeyzDkeAmSaK4cgTxN2SExNmEgXqBdTbeNJPgbSN9sbZrPMJXMSOAZ1i001kZ/LQP82aKspTdWWSz2WrmcuPw18jfUxHGda9qR46KwPVGeKFZ3pc/hsMcvPCmWyM6o9m8EhOwKCtKlUmrKWXWbCQullnI8zeBfNfTVCsQUC6QhQ+xin6mRHyinxMT7JzNEX8RUM49SvgYr5ZvMsNUrTcHdrl2u/5ihNu8Y0hyLqo5uP5OpcZrDPJylIKJ1vsKTnk9Uf5GMOrHlpNMd6G3guK3RBQBGoJISdpDU/jchyhOXNg/iaNKpiHc4TO/Ggm0Wlf325U5u04M5UrfPm80y08Szaz40S67QCQuHDBHdlRDWff6xwXwg6LMNEkkS4G966iKhbMWmx4mw6sc9YRNcdSlHixe7unJaFAolif75tuH6J8h5gCpVR/zJrUqZ6mYilfe3OkUCHAWVmlFlnzCdmyLUtowkWm5LJ9Y+JmpduiuslReq9+10muWeleV0hjLZbKkv6dLM0SIieSruuqGcAJ+ns6yJrxiYhuugU5NYR1O9vnsjrA5Dk/rYUgAa+He0ccN/xaCFnXelQRZqJuZxtnZqsGMzJAjTSX0mSgE5nMdZBXiDOtTQ9GCTC+h1QWHRSmEsuLgmfZSJnpj2C1uc3/wppZGnoUpuX873P9xOkmAgoQhg/h4IxzluCZVBq8DeHJrDAPNlm/UBPLKYFA9vSStNRYn97ero0oAgVPJdrHQ2A31s1pl85E04IfMYEUBvKscNYPrczsGAWyab2CIYOgjGWKwbbBNVgCmugMxEjL4E3TtsfOCv1LUj6pia2IibvayS9AP2YS+M7qbLv6euSNG0pGTUw3shT+bSYTg09UCss7eTL+aQwkiIigbj5Qc6AljZ2OdCbZvL3mdqQ0YxKl+UMXHp0GByN4vIqnji6mtwDdAnLcq1UjhbfQCQR5fo8AoxLeBc0Uej7zSYQcoGkAcQCput33y2YHcIAhhZNBs9tpHTlE0vJbE2kp8xui94ahYWRhHKcUguHa0xz66jipXl28Ey/Kjj+fxFxJPcYU2O8JtL49Vcy+00gplH787pj/PKfZlLmrc1hw+b6RQj5dPnMmRa2MukXMdy+jajOXDr8BP+zmUK5U+hNxHumiECkAHl1YI9lcRQxawag=")
