AMST_SHARE = AMST_SHARE or {}
AMST_SHARE["CR>P/R.LOADED"] = true
local VERSION = "v1.2.0"
local printMsgPrefix = "[CR>P/R|" .. VERSION .. "] "

---Print message with CR prefix
---@param msg string
local function Print(msg)
    GMR.Print(printMsgPrefix .. msg)
end

local function Error(msg)
    Print(printMsgPrefix .. "[ERROR]  " .. msg)
end

local CLASS_WARRIOR = 1
local CLASS_PALADIN = 2
local CLASS_HUNTER = 3
local CLASS_ROGUE = 4
local CLASS_PRIEST = 5
local CLASS_DEATHKNIGHT = 6
local CLASS_SHAMAN = 7
local CLASS_MAGE = 8
local CLASS_WARLOCK = 9
local CLASS_MONK = 10
local CLASS_DRUID = 11
local CLASS_DEMONHUNTER = 12
local CLASS_EVOKER = 13

local spells = {
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
}

local spellKnown = {
    exorcism = GMR.IsSpellKnown(spells.exorcism),
    flashOfLight = GMR.IsSpellKnown(spells.flashOfLight),
    hammerOfWrath = GMR.IsSpellKnown(spells.hammerOfWrath),
    handOfReckoning = GMR.IsSpellKnown(spells.handOfReckoning),
    purify = GMR.IsSpellKnown(spells.purify),
    cleanse = GMR.IsSpellKnown(spells.cleanse),
    crusaderStrike = GMR.IsSpellKnown(spells.crusaderStrike),
    consecrations = GMR.IsSpellKnown(spells.consecrations),
    divineStorm = GMR.IsSpellKnown(spells.divineStorm),
    judgementOfLight = GMR.IsSpellKnown(spells.judgementOfLight),
    judgementOfWisdom = GMR.IsSpellKnown(spells.judgementOfWisdom),
    judgementOfJustice = GMR.IsSpellKnown(spells.judgementOfJustice),
}

local buffs = {
    theArtOfWar = GetSpellInfo(59578),
}

local debuffs = {
    hammerOfJustice = GetSpellInfo(10308),
    wintersChill = GetSpellInfo(12579),
    improvedScorch = GetSpellInfo(22959),
    livingBomb = GetSpellInfo(44457),
    corruption = GetSpellInfo(27216),
    ignite = GetSpellInfo(12654),
    frostFever = GetSpellInfo(55095),
    frostbite = GetSpellInfo(12494),
    righteousVengeance = GetSpellInfo(61840),
    chainsOfIce = GetSpellInfo(45524),
    seedOfCorruption = GetSpellInfo(27243),
    strangulate = GetSpellInfo(47476),
    infectedWounds = GetSpellInfo(58181),
    coneOfCold = GetSpellInfo(27087),
    flameShock = GetSpellInfo(25457),
    moonfire = GetSpellInfo(26988),
    holyVengeance = GetSpellInfo(31803),
    thunderclap = GetSpellInfo(15588),
    woundPoison5 = GetSpellInfo(27189),
    shatteredBarrier = GetSpellInfo(55080),
    judgementOfLight = GetSpellInfo(20185),
    shadowWordPain = GetSpellInfo(25367),
    silencedShieldOfTheTemplar = GetSpellInfo(63529),
    psychicScream = GetSpellInfo(10890),
    bloodPlague = GetSpellInfo(55078),
    huntersMark = GetSpellInfo(14325),
    vampiricTouch = GetSpellInfo(34917),
    frostNova = GetSpellInfo(27088),
    judgementOfJustice = GetSpellInfo(20184),
    vindication = GetSpellInfo(26017),
    chilled = GetSpellInfo(7321),
    devouringPlague = GetSpellInfo(25467),
    insectSwarm = GetSpellInfo(27013),
    repentance = GetSpellInfo(20066),
    frostbolt = GetSpellInfo(38697),
    serpentSting = GetSpellInfo(27016),
    earthAndMoon = GetSpellInfo(60433),
    shadowfury = GetSpellInfo(30414),
    immolate = GetSpellInfo(27215),
    viperSting = GetSpellInfo(3034),
    unstableAffliction = GetSpellInfo(31117),
    haunt = GetSpellInfo(59161),
    ebonPlague = GetSpellInfo(51735),
    deathCoil = GetSpellInfo(27223),
    judgementOfWisdom = GetSpellInfo(20186),
    deadlyPoison = GetSpellInfo(34655),
    silencingShot = GetSpellInfo(34490),
    psychicHorror = GetSpellInfo(64044),
    deadlyPoison7 = GetSpellInfo(27187),
    avengersShield = GetSpellInfo(32700),
    mindTrauma = GetSpellInfo(48301),
    shadowMastery = GetSpellInfo(17800),
    shadowEmbrace = GetSpellInfo(32391),
    earthbind = GetSpellInfo(3600),
    dragonsBreath = GetSpellInfo(33043),
    cripplingPoison = GetSpellInfo(3409),
    spellLock = GetSpellInfo(24259),
    faerieFire = GetSpellInfo(770),
}

local debuffIndex = {}
for _, v in pairs(debuffs) do
    debuffIndex[v] = true
end

local debuffsLowPriority = {
    debuffs.wintersChill,
    debuffs.improvedScorch,
    debuffs.corruption,
    debuffs.ignite,
    debuffs.righteousVengeance,
    debuffs.flameShock,
    debuffs.moonfire,
    debuffs.holyVengeance,
    debuffs.judgementOfLight,
    debuffs.shadowWordPain,
    debuffs.bloodPlague,
    debuffs.chilled,
    debuffs.serpentSting,
    debuffs.judgementOfWisdom,
    debuffs.deadlyPoison,
    debuffs.deadlyPoison7,
    debuffs.shadowMastery,
    debuffs.ebonPlague,
    debuffs.frostFever,
    debuffs.huntersMark,
    debuffs.faerieFire,
    debuffs.vindication,
    debuffs.frostbolt,
}

local debuffNotRecommendDispelList = {
    debuffs.livingBomb,
    debuffs.vampiricTouch
}

local debuffNeverDispelList = {
    debuffs.unstableAffliction,
}

local debuffTopPriorityList = {
    debuffs.frostbite,
    debuffs.chainsOfIce,
    debuffs.hammerOfJustice,
    debuffs.seedOfCorruption,
    debuffs.strangulate,
    debuffs.thunderclap,
    debuffs.woundPoison5,
    debuffs.shatteredBarrier,
    debuffs.silencedShieldOfTheTemplar,
    debuffs.psychicScream,
    debuffs.frostNova,
    debuffs.judgementOfJustice,
    debuffs.repentance,
    debuffs.shadowfury,
    debuffs.viperSting,
    debuffs.haunt,
    debuffs.deathCoil,
    debuffs.silencingShot,
    debuffs.psychicHorror,
    debuffs.spellLock,
}

local debuffCleanseClassWhiteList = {
    [debuffs.huntersMark] = { CLASS_DRUID, CLASS_ROGUE },
    [debuffs.faerieFire] = { CLASS_DRUID, CLASS_ROGUE },
    [debuffs.frostFever] = { CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATHKNIGHT, CLASS_SHAMAN, CLASS_MONK, CLASS_DRUID, CLASS_DEMONHUNTER },
    [debuffs.vindication] = { CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATHKNIGHT, CLASS_SHAMAN, CLASS_MONK, CLASS_DRUID, CLASS_DEMONHUNTER }, -- melee only
    [debuffs.frostbolt] = { CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATHKNIGHT, CLASS_SHAMAN, CLASS_MONK, CLASS_DRUID, CLASS_DEMONHUNTER },
}

local debuffSpecialAction = {
}

local glyphSpells = {
}

---@class PaladinConfig
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = false,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = false,
    ---Use online loading feature to get last updates
    onlineLoad = true,
    consumeArtOfWarFlashLightMinHp = 80,
    consumeArtOfWarFlashLightIfAuraDepletedSoon = true,
    useConsecrationsMinEnemies = 2,
    useDivineStormMinEnemies = 2,

    groupCleanseModEnabled = false,
    useJudgmentType = 1, -- 1 - Judgement of Light, 2 - Judgement of Wisdom, 3 - Judgement of Justice
    useJudgmentCooldown = 10,

    useHandOfReckoningToMakeDamage = true,
}

function Config:new()
    local o = {}
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
            Print("Unknown config key '" .. tostring(k) .. "', skip.")
        elseif self[k] ~= v then
            Print("Option '" .. tostring(k) .. "' changed from '" .. tostring(self[k]) .. "' to '" .. tostring(v) .. "'.")
            self[k] = v
        end
    end
end

---@class PaladinState
local State = {
    judgmentToUse = spells.judgementOfLight,
    judgmentToUseKnown = spellKnown.judgementOfLight,
    judgmentToUseDebuff = debuffs.judgementOfLight,
}

function State:new()
    local o = { }
    setmetatable(o, self)
    self.__index = self
    return o
end

---Determine state
---@param cfg PaladinConfig config
---@return void
function State:determine(cfg)
    if cfg.useJudgmentType == 2 and spellKnown.judgementOfWisdom then
        self.judgmentToUse = spells.judgementOfWisdom
        self.judgmentToUseKnown = spellKnown.judgementOfWisdom
        self.judgmentToUseDebuff = debuffs.judgementOfWisdom
    elseif cfg.useJudgmentType == 3 and spellKnown.judgementOfJustice then
        self.judgmentToUse = spells.judgementOfJustice
        self.judgmentToUseKnown = spellKnown.judgementOfJustice
        self.judgmentToUseDebuff = debuffs.judgementOfJustice
    end
end

---@param cfg PaladinConfig
---@return fun(msg:string):void
local function createDbgPrintFunc(cfg)
    if cfg.debug == false then
        return function()
        end
    end

    return function(msg)
        local message = "[DEBUG] " .. msg
        GMR.Print(message)
        GMR.Log(message)
    end
end

---@class PaladinRotation
local Rotation = {
    ---@type PaladinConfig
    cfg = nil,
    ---@type PaladinState
    state = nil,
    ---@type fun(msg:string):void
    dbgPrint = function(msg)
    end
}
---@param cfg PaladinConfig
---@param state PaladinState
---@return PaladinRotation
function Rotation:new(cfg, state)
    local dbgPrint = createDbgPrintFunc(cfg)

    ---@type PaladinRotation
    local o = {
        cfg = cfg,
        state = state,
        dbgPrint = dbgPrint,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@return void
function Rotation:execute()
    if self:isStunned() then
        self.dbgPrint("player is stunned, can't do anything")
        return
    end

    if self:isSilent() then
        self.dbgPrint("player is silent, can't cast anything")
        return
    end

    local isTargetAttackable = GMR.IsAlive("target") and GMR.UnitCanAttack("player", "target")

    -- Hammer of Wrath
    if spellKnown.hammerOfWrath then
        for i = 1, #GMR.Tables.Attackables do
            local attackable = GMR.Tables.Attackables[i][1]
            if GMR.ObjectExists(attackable) and GMR.IsAlive(attackable) and GMR.GetHealth(attackable) < 20
                and GMR.IsCastable(spells.hammerOfWrath, attackable)
            then
                self.dbgPrint("should cast hammer of wrath")
                GMR.Cast(spells.hammerOfWrath, attackable)
                return
            end
        end
    end


    -- Judgement
    if self.state.judgmentToUseKnown and GetSpellCooldown(self.state.judgmentToUse) == 0 then
        local unitToCast = nil
        for i = 1, #GMR.Tables.Attackables do
            local attackable = GMR.Tables.Attackables[i][1]
            if GMR.ObjectExists(attackable) and GMR.IsCastable(self.state.judgmentToUse, attackable)
                and GMR.GetDistance("player", attackable, "<", 10)
                and GMR.GetDebuffExpiration(attackable, self.state.judgmentToUseDebuff) < self.cfg.useJudgmentCooldown
            then
                unitToCast = attackable
                break
            end
        end
        if not unitToCast and isTargetAttackable and GMR.GetDistance("player", "target", "<", 10) then
            unitToCast = "target"
        end

        if unitToCast and GMR.IsCastable(self.state.judgmentToUse, unitToCast) then
            self.dbgPrint("should cast default judgment '" .. self.state.judgmentToUse .. "'")
            GMR.Cast(self.state.judgmentToUse, unitToCast)
            return
        end
    end

    self:cleanse("player")

    if GMR.HasBuff("player", buffs.theArtOfWar) then
        if spellKnown.flashOfLight and GMR.GetHealth("player") < self.cfg.consumeArtOfWarFlashLightMinHp
            and GMR.IsCastable(spells.flashOfLight, "player")
        then
            self.dbgPrint("should cast flash of light on self to consume the art of war aura")
            GMR.Cast(spells.flashOfLight, "player")
            return
        elseif isTargetAttackable and spellKnown.exorcism and GMR.IsCastable(spells.exorcism, "target") then
            self.dbgPrint("should cast exorcism on target to consume the art of war aura")
            GMR.Cast(spells.exorcism, "target")
            return
        elseif self.cfg.consumeArtOfWarFlashLightIfAuraDepletedSoon and spellKnown.flashOfLight
            and GMR.GetBuffExpiration("player", buffs.theArtOfWar) < 2
            and GMR.GetHealth("player") < 100 and GMR.IsCastable(spells.flashOfLight, "player")
        then
            self.dbgPrint("should cast flash of light on self to consume the art of war aura. Aura will deplete soon.")
            GMR.Cast(spells.flashOfLight, "player")
            return
        end
    end

    if isTargetAttackable and GMR.IsCastable(self.state.judgmentToUse, "target") then
        self.dbgPrint("should use default judgment '" .. self.state.judgmentToUse .. "'")
        GMR.Cast(self.state.judgmentToUse, "target")
    end

    self:executeGroupCleanse()

    if isTargetAttackable and self.cfg.useHandOfReckoningToMakeDamage and spellKnown.handOfReckoning
        and not GMR.UnitIsPlayer("target") and not GMR.UnitIsUnit("targettarget", "player")
        and GMR.IsCastable(spells.handOfReckoning, "target")
    then
        self.dbgPrint("should cast hand of reckoning to make some damage")
        GMR.Cast(spells.handOfReckoning, "target")
        return
    end

    if spellKnown.consecrations and GMR.GetNumEnemies("player", 10) >= self.cfg.useConsecrationsMinEnemies
        and GMR.IsCastable(spells.consecrations, "player")
    then
        self.dbgPrint("should use consecrations")
        GMR.Cast(spells.consecrations, "player")
        return
    end

    if spellKnown.divineStorm and GMR.GetNumEnemies("player", 8) >= self.cfg.useDivineStormMinEnemies
        and GMR.IsCastable(spells.divineStorm, "player")
    then
        self.dbgPrint("should use divine storm")
        GMR.Cast(spells.divineStorm, "player")
        return
    end

    if isTargetAttackable and spellKnown.crusaderStrike and GMR.IsCastable(spells.crusaderStrike, "target") then
        self.dbgPrint("should cast crusader strike")
        GMR.Cast(spells.crusaderStrike, "target")
        return
    end
end

---@return boolean
function Rotation:isSilent()
    return false
end

---@return boolean
function Rotation:isStunned()
    if GMR.HasDebuff("player", debuffs.hammerOfJustice) then
        return true
    end

    return false
end

---@param unit string|userdata
---@return boolean Did cleanse
function Rotation:cleanse(unit)
    if GMR.GetDistance("player", unit, ">", 40) then
        return false
    end
    if spellKnown.cleanse and not GMR.IsCastable(spells.cleanse, unit) then
        return false
    elseif spellKnown.purify and not GMR.IsCastable(spells.purify, unit) then
        return false
    end

    local debuffNameToIndexMap = {}
    for index = 1, 40 do
        local localeName, _, _, debuffType, duration, expireAtTime = GMR.UnitDebuff(unit, index)
        if localeName and expireAtTime - GetTime() < duration - math.random(5, 10) / 10 then
            local isCleanable = false
            if spellKnown.cleanse and debuffType == "Disease" or debuffType == "Magic" or debuffType == "Poison" then
                isCleanable = true
            elseif spellKnown.purify and debuffType == "Disease" or debuffType == "Poison" then
                isCleanable = true
            end

            if isCleanable then
                debuffNameToIndexMap[localeName] = index
            end
        end
    end

    local shouldCleanIndex = self:shouldCleanse(unit, debuffNameToIndexMap)
    if shouldCleanIndex then
        local localeName, _, _, _, _, _, _, _, _, spellId = GMR.UnitDebuff(unit, shouldCleanIndex)
        local unknownPart = ""
        if not debuffIndex[localeName] then
            unknownPart = "UNKNOWN "
        end

        local spellSysName = ""
        local spellToCast = ""
        if spellKnown.cleanse then
            spellSysName = "cleanse"
            spellToCast = spells.cleanse
        elseif spellKnown.purify then
            spellSysName = "purify"
            spellToCast = spells.purify
        end

        self.dbgPrint("should cast " .. spellSysName .. " on '" .. unit .. "' to remove " .. unknownPart .. "debuff  '" .. localeName .. "':" .. tostring(spellId) .. ".")
        GMR.Cast(spells.cleanse, unit)
        return true
    end

    return false
end

--- @return number index
function Rotation:shouldCleanse(unit, debuffNameToIndexMap)
    for debuff, _ in pairs(debuffNameToIndexMap) do
        for _, neverDispelDebuff in ipairs(debuffNeverDispelList) do
            if neverDispelDebuff == debuff then
                return nil
            end
        end
    end

    for debuff, index in pairs(debuffNameToIndexMap) do
        for _, topPriorityDebuff in ipairs(debuffTopPriorityList) do
            if topPriorityDebuff == debuff then
                return index
            end
        end
    end

    for debuff, _ in pairs(debuffNameToIndexMap) do
        for _, notDispelDebuff in ipairs(debuffNotRecommendDispelList) do
            if notDispelDebuff == debuff then
                return nil
            end
        end
    end

    local unitClass = GMR.GetClass(unit)
    for debuff, index in pairs(debuffNameToIndexMap) do
        for whiteListDebuff, classList in pairs(debuffCleanseClassWhiteList) do
            if debuff == whiteListDebuff then
                for _, class in ipairs(classList) do
                    if class == unitClass then
                        return index
                    end
                end
            end
        end
    end

    for debuff, index in pairs(debuffNameToIndexMap) do
        local isIgnored = false
        for _, ignoredDebuff in ipairs(debuffsLowPriority) do
            if debuff == ignoredDebuff then
                isIgnored = true
                break
            end
        end

        if not isIgnored then
            return index
        end
    end

    return nil
end

---@return boolean casted something
function Rotation:executeGroupCleanse()
    if not self.cfg.groupCleanseModEnabled then
        return false
    end

    if GMR.IsMoving() and IsMounted() then
        return false
    end

    if not UnitInRaid("player") or not UnitInParty("player") then
        return false
    end

    if self:cleanse("player") then
        return true
    end

    if UnitInRaid("player") then
        for raidIndex = 1, 40 do
            local unit = "raid" .. tostring(raidIndex)
            if self:cleanse(unit) then
                return true
            end
        end
    elseif UnitInParty("player") then
        for partyIndex = 1, 4 do
            local unit = "party" .. tostring(partyIndex)
            if self:cleanse(unit) then
                return true
            end
        end
    end

    return false
end

do
    local isSuccess, err = pcall(function()
        if GMR.GetClass("player") == "PALADIN" then
            Print("Rotation would be initialized")

            local cfg = Config:new()
            cfg:apply(AMST_SHARE["CR>P/R.CFG"])

            local state = State:new()
            state:determine(cfg)

            local rotation = Rotation:new(cfg, state)
            local executeRotationFunc = function()
                local isSuccess, err = pcall(rotation.execute, rotation)
                if not isSuccess then
                    Error("Can't launch rotation: " .. err)
                end
            end

            if cfg.groupCleanseModEnabled and cfg.useCombatRotationLauncher then
                GMR.Print("You have turned on `groupCleanseModEnabled`;therefore, you should turn off `useCombatRotationLauncher` to get better results")
            end

            if cfg.useCombatRotationLauncher then
                local resultFunction = nil
                if GMR.CustomCombatConditions == nil then
                    resultFunction = executeRotationFunc
                else
                    Print("There is another combat conditions, it will be merged with this rotation")
                    local oldCombatConditions = GMR.CustomCombatConditions
                    resultFunction = function()
                        local isSuccess, err = pcall(oldCombatConditions)
                        if not isSuccess then
                            Error("Can't launch previous custom combat rotation: " .. err)
                        end
                        executeRotationFunc()
                    end
                end

                GMR.CustomCombatConditions = resultFunction
                C_Timer.NewTicker(1, function()
                    if GMR.CustomCombatConditions ~= resultFunction then
                        GMR.CustomCombatConditions = resultFunction
                        Error("Something changed GMR.CustomCombatConditions func, it was changed back!")
                    end
                end)
            else
                C_Timer.NewTicker(0.1, function()
                    if (not GMR.IsExecuting() or not GMR.IsAlive()) then
                        return
                    end

                    if GMR.IsEating("player") or GMR.IsDrinking("player") then
                        return false
                    end

                    executeRotationFunc()
                end)
            end

            Print("Rotation fully initialed and turned on.")
        end
    end)

    if not isSuccess then
        Error(err)
    end
end