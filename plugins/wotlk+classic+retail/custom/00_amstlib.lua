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
    rollTheBones = GetSpellInfo(315508),
    sinisterStrike = GetSpellInfo(193315),
    betweenTheEyes = GetSpellInfo(315341),
    pistolShot = GetSpellInfo(185763),
    dispatch = GetSpellInfo(2098),
    sliceAndDice = GetSpellInfo(315496),
    bladeRush = GetSpellInfo(271877),
    adrenalineRush = GetSpellInfo(13750),
    bladeFlurry = GetSpellInfo(13877),
    echoingReprimand = GetSpellInfo(323547),
    crimsonVial = GetSpellInfo(185311),
    kick = GetSpellInfo(1766),
    bearForm = GetSpellInfo(5487),
    swipe = GetSpellInfo(213771),
    mangle = GetSpellInfo(33917),
    thrash = GetSpellInfo(77758),
    moonfire = GetSpellInfo(8921),
    ironfur = GetSpellInfo(192081),
    bristlingFur = GetSpellInfo(155835),
    frenziedRegeneration = GetSpellInfo(22842),
    rake = GetSpellInfo(1822),
    shred = GetSpellInfo(5221),
    rip = GetSpellInfo(1079),
    ferociousBite = GetSpellInfo(22568),
    regrowth = GetSpellInfo(8936),
    thrash = GetSpellInfo(106830),
    primalWrath = GetSpellInfo(285381),
    catForm = GetSpellInfo(768),
    tigersFury = GetSpellInfo(5217),
    wildCharge = GetSpellInfo(49376),
    prowl = GetSpellInfo(5215),
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
    rollTheBones = GMR.IsSpellKnown(amstlib.CONST.SPELL.rollTheBones),
    sinisterStrike = GMR.IsSpellKnown(amstlib.CONST.SPELL.sinisterStrike),
    betweenTheEyes = GMR.IsSpellKnown(amstlib.CONST.SPELL.betweenTheEyes),
    pistolShot = GMR.IsSpellKnown(amstlib.CONST.SPELL.pistolShot),
    dispatch = GMR.IsSpellKnown(amstlib.CONST.SPELL.dispatch),
    sliceAndDice = GMR.IsSpellKnown(amstlib.CONST.SPELL.sliceAndDice),
    bladeRush = GMR.IsSpellKnown(amstlib.CONST.SPELL.bladeRush),
    adrenalineRush = GMR.IsSpellKnown(amstlib.CONST.SPELL.adrenalineRush),
    bladeFlurry = GMR.IsSpellKnown(amstlib.CONST.SPELL.bladeFlurry),
    echoingReprimand = GMR.IsSpellKnown(amstlib.CONST.SPELL.echoingReprimand),
    crimsonVial = GMR.IsSpellKnown(amstlib.CONST.SPELL.crimsonVial),
    kick = GMR.IsSpellKnown(amstlib.CONST.SPELL.kick),
    bearForm = GMR.IsSpellKnown(amstlib.CONST.SPELL.bearForm),
    swipe = GMR.IsSpellKnown(amstlib.CONST.SPELL.swipe),
    mangle = GMR.IsSpellKnown(amstlib.CONST.SPELL.mangle),
    thrash = GMR.IsSpellKnown(amstlib.CONST.SPELL.thrash),
    moonfire = GMR.IsSpellKnown(amstlib.CONST.SPELL.moonfire),
    ironfur = GMR.IsSpellKnown(amstlib.CONST.SPELL.ironfur),
    bristlingFur = GMR.IsSpellKnown(amstlib.CONST.SPELL.bristlingFur),
    frenziedRegeneration = GMR.IsSpellKnown(amstlib.CONST.SPELL.frenziedRegeneration),
    rake = GMR.IsSpellKnown(amstlib.CONST.SPELL.rake),
    shred = GMR.IsSpellKnown(amstlib.CONST.SPELL.shred),
    rip = GMR.IsSpellKnown(amstlib.CONST.SPELL.rip),
    ferociousBite = GMR.IsSpellKnown(amstlib.CONST.SPELL.ferociousBite),
    regrowth = GMR.IsSpellKnown(amstlib.CONST.SPELL.regrowth),
    thrash = GMR.IsSpellKnown(amstlib.CONST.SPELL.thrash),
    primalWrath = GMR.IsSpellKnown(amstlib.CONST.SPELL.primalWrath),
    catForm = GMR.IsSpellKnown(amstlib.CONST.SPELL.catForm),
    tigersFury = GMR.IsSpellKnown(amstlib.CONST.SPELL.tigersFury),
    prowl = GMR.IsSpellKnown(amstlib.CONST.SPELL.prowl),
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
    grandMelee = GetSpellInfo(193358),
    broadside = GetSpellInfo(193356),
    ruthlessPrecision = GetSpellInfo(193357),
    buriedTreasure = GetSpellInfo(199600),
    skullAndCrossbones = GetSpellInfo(199603),
    trueBearing = GetSpellInfo(193359),
    opportunity = GetSpellInfo(195627),
    sliceAndDice = GetSpellInfo(315496),
    echoingReprimand = GetSpellInfo(323560),
    bearForm = GetSpellInfo(5487),
    frenziedRegeneration = GetSpellInfo(22842),
    predatorySwiftness = GetSpellInfo(69369),
    catForm = GetSpellInfo(768),
    prowl = GetSpellInfo(5215),
}
amstlib.CONST.DEBUFF = {
    sinfulBrand = GetSpellInfo(317009),
    rake = GetSpellInfo(155722),
    rip = GetSpellInfo(1079),
    thrash = GetSpellInfo(106830),
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
---@type boolean
AmstLibCombatRotation.isPrepared = false
---@type boolean
AmstLibCombatRotation.isInitialized = false
AmstLibCombatRotation.version = ""
AmstLibCombatRotation.msgPrefix = "[CR]"
AmstLibCombatRotation.previousDbgMessagePerSlot = {}
AmstLibCombatRotation.config = {
    onlineLoad = true,
    debug = false,
    ---@type boolean
    useCombatRotationLauncher = true,
}

---@param id string
---@return AmstLibCombatRotation
function AmstLibCombatRotation:new(id)
    ---@type AmstLibCombatRotation
    local o = { id = id }
    setmetatable(o, self)
    self.__index = self

    o.msgPrefix = "[" .. id .. "]"

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
---@param config table
---@return boolean, string result and details
function AmstLibCombatRotation:prepare(config)
    self:validateConfig(config)

    self.config = config
    self.isPrepared = true
end

---@param msg string
---@return void
function AmstLibCombatRotation:print(msg)
    GMR.Print(self.msgPrefix .. " " .. msg)
end

---@param msg string
---@param slot number
---@return void
function AmstLibCombatRotation:printDbg(msg, slot)
    slot = slot or 1
    if not self.config.debug then
        return
    end

    if msg == self.previousDbgMessagePerSlot[slot] then
        return
    end

    GMR.Print(self.msgPrefix .. "[DEBUG] " .. tostring(msg))
    self.previousDbgMessagePerSlot[slot] = msg
end

---@param msg string
---@return void
function AmstLibCombatRotation:printError(msg)
    GMR.Print(self.msgPrefix .. "[ERROR] " .. tostring(msg))
end

function AmstLibCombatRotation:getConfig()
    if not self.isPrepared then
        error("Combat rotation is not prepared")
    end

    return self.config
end

---@return boolean, string result and details
function AmstLibCombatRotation:load(link)
    if not self.isPrepared then
        error("rotation not prepared, should call prepare() func first")
        return
    end

    if self.config.onlineLoad then
        GMR.SendHttpRequest({
            Url = link,
            Method = "Get",
            Callback = function(content)
                RunScript(content)
                if not self.isInitialized then
                    self:printError("Rotation have not loaded properly!")
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
    if not self.isPrepared then
        error("rotation is not prepared")
    end
    self.version = version
    self.msgPrefix = "[" .. self.id .. "|" .. version .. "]"

    if not checkFunc() then
        return false
    end

    if self.isInitialized then
        self:print("this combat rotation already initialized, nothing new will happen")
        return
    end
    self.isInitialized = true

    self:print("Rotation would be initialized")
    local rotation = rotationCreateFunc()
    local executeRotationFunc = function()
        local isSuccess, err = pcall(rotation)
        if not isSuccess then
            self:printError("Can't launch rotation: " .. err)
        end
    end

    if self.config.useCombatRotationLauncher then
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

---Check is spell castable. I have to add this method, because original GMR.IsCastable and even WoW's API methods not
---works properly with some melee spells (Retail Rogue, Retail Demon Hunter) and can't determine properly valid
---destination (it think valid destination is shorter).
---
---@param spellToCheckRange string spell, that would be used to determine real destination instead of spell with issue
---@return fun(spell:string, unit:string):boolean
function amstlib.createIsCastableFunc(spellToCheckRange)
    return function(spell, unit)
        local isSpellInRange = GMR.IsSpellInRange(spell, unit)
        if isSpellInRange == nil then
            GMR.IsSpellInRange(spellToCheckRange, unit)
        end
        return isSpellInRange
            and GMR.IsSpellUsable(spell)
            and GetSpellCooldown(spell) == 0
            and GMR.InLoS("player", unit)
    end
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

function amstlib.Util.printTable(tbl)
    for k, v in pairs(tbl) do
        GMR.Print("[" .. tostring(k) .. "] => '" .. tostring(v) .. "'")
    end
end

GMR.RunEncryptedScript("Dwmp8SO47wDMnLB/XJotsZJa5KoW8faR2zg83EqLjzRVtrkO/DLLEcFo6KPvGFA+njoS/OpjAHEZl0quNwCeSoGYpfZo/peHfGokp5sFO+lkbWYyDLiT+wNbmcsvnVT04cCB0gjbmb27mXjaKZti7fXg/zCc2p7pKEJyyb/0jyMJIBDfBgwfCYZYhNHlJcQmTAYlGXaH/L1bKKiWVP5vvt8M2ih6LcMfvwI4FL0UlDRHGPgrxxIHcd08YpniWZtYp90BmtWNfm7Dan0OtU7+CIvKoOf8KpLibhboN4j046aBG6TV7ZI99aV1PrYN4ufeCuu0p+QhL/qtE6Ww9LYScpM9XF0uulhbztSylZY+RbGQWt8cpebvwZctFnuN6iB4df1tW4AfBgg+J2F3tgt1j7rlrMNPZeyzDkeAmSaK4cgTxN2SExNmEgXqBdTbeNJPgbSN9sbZrPMJXMSOAZ1i001kZ/LQP82aKspTdWWSz2WrmcuPw18jfUxHGda9qR46KwPVGeKFZ3pc/hsMcvPCmWyM6o9m8EhOwKCtKlUmrKWXWbCQullnI8zeBfNfTVCsQUC6QhQ+xin6mRHyinxMT7JzNEX8RUM49SvgYr5ZvMsNUrTcHdrl2u/5ihNu8Y0hyLqo5uP5OpcZrDPJylIKJ1vsKTnk9Uf5GMOrHlpNMd6G3guK3RBQBGoJISdpDU/jchyhOXNg/iaNKpiHc4TO/Ggm0Wlf325U5u04M5UrfPm80y08Szaz40S67QCQuHDBHdlRDWff6xwXwg6LMNEkkS4G966iKhbMWmx4mw6sc9YRNcdSlHixe7unJaFAolif75tuH6J8h5gCpVR/zJrUqZ6mYilfe3OkUCHAWVmlFlnzCdmyLUtowkWm5LJ9Y+JmpduiuslReq9+10muWeleV0hjLZbKkv6dLM0SIieSruuqGcAJ+ns6yJrxiYhuugU5NYR1O9vnsjrA5Dk/rYUgAa+He0ccN/xaCFnXelQRZqJuZxtnZqsGMzJAjTSX0mSgE5nMdZBXiDOtTQ9GCTC+h1QWHRSmEsuLgmfZSJnpj2C1uc3/wppZGnoUpuX873P9xOkmAgoQhg/h4IxzluCZVBq8DeHJrDAPNlm/UBPLKYFA9vSStNRYn97ero0oAgVPJdrHQ2A31s1pl85E04IfMYEUBvKscNYPrczsGAWyab2CIYOgjGWKwbbBNVgCmugMxEjL4E3TtsfOCv1LUj6pia2IibvayS9AP2YS+M7qbLv6euSNG0pGTUw3shT+bSYTg09UCss7eTL+aQwkiIigbj5Qc6AljZ2OdCbZvL3mdqQ0YxKl+UMXHp0GByN4vIqnji6mtwDdAnLcq1UjhbfQCQR5fo8AoxLeBc0Uej7zSYQcoGkAcQCput33y2YHcIAhhZNBs9tpHTlE0vJbE2kp8xui94ahYWRhHKcUguHa0xz66jipXl28Ey/Kjj+fxFxJPcYU2O8JtL49Vcy+00gplH787pj/PKfZlLmrc1hw+b6RQj5dPnMmRa2MukXMdy+jajOXDr8BP+zmUK5U+hNxHumiECkAHl1YI9lcRQxawag=")

-- ---------------- --
-- --- TRINKETS --- --
-- ---------------- --

amstlib.CONST.TRINKET_TYPE = {
    SELF_BUFF = 1,
    TARGET_HARMFUL = 2,
    AOE_HARMFUL = 3,
}

---@class AmstLibTrinket
AmstLibTrinket = {}
---@type number
AmstLibTrinket.index = 0
---@type number
AmstLibTrinket.inventoryId = 0
---@type number
AmstLibTrinket.type = 0

---@return AmstLibTrinket
function AmstLibTrinket:new(index, type)
    local inventoryId = 0
    if index == 1 then
        inventoryId = amstlib.CONST.INVENTORY.SLOT_ID.TRINKET_1
    elseif index == 2 then
        inventoryId = amstlib.CONST.INVENTORY.SLOT_ID.TRINKET_2
    else
        error("invalid trinket index '" .. tostring(type) .. "'")
    end

    if type ~= amstlib.CONST.TRINKET_TYPE.SELF_BUFF and type ~= amstlib.CONST.TRINKET_TYPE.TARGET_HARMFUL
        and type ~= amstlib.CONST.TRINKET_TYPE.AOE_HARMFUL
    then
        error("invalid type '" .. tostring(type) .. "'")
    end

    local o = {
        index = index,
        inventoryId = inventoryId,
        type = type,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@class AmstLibTrinketer
AmstLibTrinketer = {}
---@type AmstLibCombatRotation
AmstLibTrinketer.cr = nil
---@type AmstLibTrinket[]
AmstLibTrinketer.trinkets = {}
---@type boolean
AmstLibTrinketer.isInitialized = false
AmstLibTrinketer.spellToCheckGCD = ""

---@param cr AmstLibCombatRotation
function AmstLibTrinketer:new(cr)
    local o = { cr = cr }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@param spellToCheckGCD string
---@return void
function AmstLibTrinketer:initialize(spellToCheckGCD)
    if not self.cr.isPrepared then
        error("can't initialize trinket usage, because rotation not prepared")
    end
    if not spellToCheckGCD then
        error("spell to check GCD is empty")
    end

    local fieldsToUse = { "useTrinket1", "useTrinket1Type", "useTrinket2", "useTrinket2Type" }
    local missedFields = {}
    for _, field in ipairs(fieldsToUse) do
        local cfg = self.cr:getConfig()
        self.cr:printDbg("field: " .. tostring(cfg.onlineLoad))
        if self.cr:getConfig()[field] == nil then
            table.insert(missedFields, field)
        end
    end

    if #missedFields > 0 then
        local fieldsAsStr = ""
        for i, f in ipairs(missedFields) do
            if i > 1 then
                fieldsAsStr = fieldsAsStr .. ", "
            end
            fieldsAsStr = fieldsAsStr .. f
        end
        self.cr:printError("can't initialize trinket usage, because config do not have necessary fields: " .. fieldsAsStr)
        return
    end

    self.spellToCheckGCD = spellToCheckGCD

    local trinketRawData = {}
    if self.cr:getConfig()["useTrinket1"] then
        table.insert(trinketRawData, { 1, self.cr:getConfig()["useTrinket1Type"] })
    end
    if self.cr:getConfig()["useTrinket2"] then
        table.insert(trinketRawData, { 2, self.cr:getConfig()["useTrinket2Type"] })
    end
    for _, trinketData in ipairs(trinketRawData) do
        local trinket = AmstLibTrinket:new(trinketData[1], trinketData[2])
        table.insert(self.trinkets, trinket)
        self.cr:print("Character will use trinket with inventory id '" .. tostring(trinket.inventoryId) .. "' type '" .. tostring(trinket.type) .. "' ")
    end

    self.isInitialized = true
end

---@return boolean has been used
function AmstLibTrinketer:useTrinkets()
    if not self.isInitialized then
        return false
    end

    for _, trinket in ipairs(self.trinkets) do
        local itemId = GetInventoryItemID("player", trinket.inventoryId)
        local cooldownStart, duration = GetItemCooldown(itemId)
        if cooldownStart == 0 and GMR.IsCastable(self.spellToCheckGCD, "player") then
            if trinket.type == amstlib.CONST.TRINKET_TYPE.AOE_HARMFUL then
                if not GMR.IsMoving() and GMR.GetNumEnemies("player", 15) >= 1 then
                    self.cr:printDbg("should use trinket #" .. tostring(trinket.index) .. " as AOE")
                    GMR.RunMacroText("/use [@player] " .. tostring(trinket.inventoryId))
                    return true
                end
            elseif trinket.type == amstlib.CONST.TRINKET_TYPE.SELF_BUFF
                and GMR.GetDistance("player", "target", "<", 6)
            then
                self.cr:printDbg("should use trinket #" .. tostring(trinket.index) .. " as self-buff")
                GMR.Use(itemId)
                return true
            elseif trinket.type == amstlib.CONST.TRINKET_TYPE.TARGET_HARMFUL
                and GMR.GetDistance("player", "target", "<", 6)
            then
                self.cr:printDbg("should use trinket #" .. tostring(trinket.index) .. " as target harmful")
                GMR.Use(itemId)
                return true
            end
        end
    end

    return false
end