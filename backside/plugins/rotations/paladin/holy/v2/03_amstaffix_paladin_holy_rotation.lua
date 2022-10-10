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

local ok, err = pcall(function()
    local ID = "CR>P/H"
    local VERSION = "v2.0.0"

    local buffSameClassLists = {
        { amstlib.CONST.BUFF.greaterBlessingOfMight, amstlib.CONST.BUFF.blessingOfMight, amstlib.CONST.BUFF.battleShout },
        { amstlib.CONST.BUFF.greaterBlessingOfKings, amstlib.CONST.BUFF.blessingOfKings },
    }

    local debuffIndex = {}
    for _, v in pairs(amstlib.CONST.DEBUFF) do
        debuffIndex[v] = true
    end

    local debuffsLowPriority = {
        amstlib.CONST.DEBUFF.wintersChill,
        amstlib.CONST.DEBUFF.improvedScorch,
        amstlib.CONST.DEBUFF.corruption,
        amstlib.CONST.DEBUFF.ignite,
        amstlib.CONST.DEBUFF.righteousVengeance,
        amstlib.CONST.DEBUFF.flameShock,
        amstlib.CONST.DEBUFF.moonfire,
        amstlib.CONST.DEBUFF.holyVengeance,
        amstlib.CONST.DEBUFF.judgementOfLight,
        amstlib.CONST.DEBUFF.shadowWordPain,
        amstlib.CONST.DEBUFF.bloodPlague,
        amstlib.CONST.DEBUFF.chilled,
        amstlib.CONST.DEBUFF.serpentSting,
        amstlib.CONST.DEBUFF.judgementOfWisdom,
        amstlib.CONST.DEBUFF.deadlyPoison,
        amstlib.CONST.DEBUFF.deadlyPoison7,
        amstlib.CONST.DEBUFF.shadowMastery,
        amstlib.CONST.DEBUFF.ebonPlague,
        amstlib.CONST.DEBUFF.frostFever,
        amstlib.CONST.DEBUFF.huntersMark,
        amstlib.CONST.DEBUFF.faerieFire,
        amstlib.CONST.DEBUFF.vindication,
        amstlib.CONST.DEBUFF.frostbolt,
        amstlib.CONST.DEBUFF.cryptFever,
        amstlib.CONST.DEBUFF.blackArrow,
        amstlib.CONST.DEBUFF.faerieFireFeral,
    }

    local debuffNotRecommendDispelList = {
        amstlib.CONST.DEBUFF.livingBomb,
        amstlib.CONST.DEBUFF.vampiricTouch
    }

    local debuffNeverDispelList = {
        amstlib.CONST.DEBUFF.unstableAffliction,
    }

    local debuffTopPriorityList = {
        amstlib.CONST.DEBUFF.frostbite,
        amstlib.CONST.DEBUFF.chainsOfIce,
        amstlib.CONST.DEBUFF.hammerOfJustice,
        amstlib.CONST.DEBUFF.strangulate,
        amstlib.CONST.DEBUFF.thunderclap,
        amstlib.CONST.DEBUFF.woundPoison5,
        amstlib.CONST.DEBUFF.shatteredBarrier,
        amstlib.CONST.DEBUFF.silencedShieldOfTheTemplar,
        amstlib.CONST.DEBUFF.psychicScream,
        amstlib.CONST.DEBUFF.frostNova,
        amstlib.CONST.DEBUFF.judgementOfJustice,
        amstlib.CONST.DEBUFF.repentance,
        amstlib.CONST.DEBUFF.shadowfury,
        amstlib.CONST.DEBUFF.viperSting,
        amstlib.CONST.DEBUFF.haunt,
        amstlib.CONST.DEBUFF.deathCoil,
        amstlib.CONST.DEBUFF.silencingShot,
        amstlib.CONST.DEBUFF.psychicHorror,
        amstlib.CONST.DEBUFF.spellLock,
        amstlib.CONST.DEBUFF.freezingTrapEffect,
        amstlib.CONST.DEBUFF.markOfBlood,
        amstlib.CONST.DEBUFF.freeze,
    }

    local debuffCleanseClassWhiteList = {
        [amstlib.CONST.DEBUFF.huntersMark] = { amstlib.CONST.CLASS.DRUID, amstlib.CONST.CLASS.ROGUE },
        [amstlib.CONST.DEBUFF.faerieFire] = { amstlib.CONST.CLASS.DRUID, amstlib.CONST.CLASS.ROGUE },
        [amstlib.CONST.DEBUFF.faerieFireFeral] = { amstlib.CONST.CLASS.DRUID, amstlib.CONST.CLASS.ROGUE },
        [amstlib.CONST.DEBUFF.frostFever] = { amstlib.CONST.CLASS.WARRIOR, amstlib.CONST.CLASS.PALADIN, amstlib.CONST.CLASS.HUNTER, amstlib.CONST.CLASS.ROGUE, amstlib.CONST.CLASS.DEATHKNIGHT, amstlib.CONST.CLASS.SHAMAN, amstlib.CONST.CLASS.MONK, amstlib.CONST.CLASS.DRUID, amstlib.CONST.CLASS.DEMONHUNTER },
        [amstlib.CONST.DEBUFF.vindication] = { amstlib.CONST.CLASS.WARRIOR, amstlib.CONST.CLASS.PALADIN, amstlib.CONST.CLASS.HUNTER, amstlib.CONST.CLASS.ROGUE, amstlib.CONST.CLASS.DEATHKNIGHT, amstlib.CONST.CLASS.SHAMAN, amstlib.CONST.CLASS.MONK, amstlib.CONST.CLASS.DRUID, amstlib.CONST.CLASS.DEMONHUNTER }, -- melee only
        [amstlib.CONST.DEBUFF.frostbolt] = { amstlib.CONST.CLASS.WARRIOR, amstlib.CONST.CLASS.PALADIN, amstlib.CONST.CLASS.HUNTER, amstlib.CONST.CLASS.ROGUE, amstlib.CONST.CLASS.DEATHKNIGHT, amstlib.CONST.CLASS.SHAMAN, amstlib.CONST.CLASS.MONK, amstlib.CONST.CLASS.DRUID, amstlib.CONST.CLASS.DEMONHUNTER },
        [amstlib.CONST.DEBUFF.chilled] = { amstlib.CONST.CLASS.WARRIOR, amstlib.CONST.CLASS.PALADIN, amstlib.CONST.CLASS.HUNTER, amstlib.CONST.CLASS.ROGUE, amstlib.CONST.CLASS.DEATHKNIGHT, amstlib.CONST.CLASS.SHAMAN, amstlib.CONST.CLASS.MONK, amstlib.CONST.CLASS.DRUID, amstlib.CONST.CLASS.DEMONHUNTER },
    }

    local debuffCustomLogicList = {
        amstlib.CONST.DEBUFF.livingBomb,
    }

    local debuffBlessingOfFreedomList = {
        amstlib.CONST.DEBUFF.envelopingWeb,
    }

    ---@class PaladinHolyV2Config
    local Config = {
        ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
        ---to author.
        debug = false,
        ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
        useCombatRotationLauncher = true,
        ---Use online loading feature to get last updates
        onlineLoad = true,

        useConsecrations = true,
        useConsecrationsMinEnemies = 1,

        groupCleanseModEnabled = false,
        useJudgmentType = 1, -- 1:Judgement of Light; 2:Judgement of Wisdom; 3:Judgement of Justice;
        useJudgmentTryToCleave = true,
        useJudgmentForDebuffOnly = false,

        useHandOfReckoningToMakeDamage = true,
        useHandOfReckoningInInstance = false,

        defaultAuraToUse = 1, -- 1:Devotion Aura; 2:Retribution Aura; 3:Concentration Aura; 4:Shadow Resistance Aura; 5:Frost Resistance Aura; 6:Fire Resistance Aura
        defaultAuraChangeIfAlreadyExist = { 2, 3 }, -- 1:Devotion Aura; 2:Retribution Aura; 3:Concentration Aura; 4:Shadow Resistance Aura; 5:Frost Resistance Aura; 6:Fire Resistance Aura
        defaultBlessingToUse = 4, -- 1:Blessing of Might; 2:Blessing of Kings; 3:Blessing of Wisdom; 4:Blessing of Sanctuary;
        defaultSealToUse = 4, -- 1:Seal of Righteousness; 2:Seal of Justice; 3:Seal of Light; 4:Seal of Wisdom; 5:Seal of Command; 6:Seal of Corruption;
        defaultSealDoNotSwitchList = { 6 }, -- 1:Seal of Righteousness; 2:Seal of Justice; 3:Seal of Light; 4:Seal of Wisdom; 5:Seal of Command; 6:Seal of Corruption;

        useCrusaderAuraWhileMounted = true,
        useCrusaderAuraWhileMounterMinDistance = 50,

        useBlessingOfFreedom = true,

        groupBuffModEnabled = true,
        groupBuffModMinMana = 70,

        useAggroSpellsInGroup = true,
        useTrinket1 = false,
        useTrinket1Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful

        useTrinket2 = false,
        useTrinket2Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful

        ---@type AmstLibCombatRotation
        cr = nil
    }

    ---@param cr AmstLibCombatRotation
    ---@return PaladinHolyV2Config
    function Config:new(cr)
        local o = {
            cr = cr,
        }
        setmetatable(o, self)
        self.__index = self
        return o
    end

    ---Apply object to change default values
    ---@param object PaladinHolyV2Config another config
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

    local function HasBuffClassed(unit, buff, byPlayer)
        local hasSameClassBuff = false
        local sameClassBuffList = nil
        for _, list in ipairs(buffSameClassLists) do
            for _, buffFromList in ipairs(list) do
                if buff == buffFromList then
                    hasSameClassBuff = true
                    sameClassBuffList = list
                    break
                end
            end
            if hasSameClassBuff then
                break
            end
        end

        if not hasSameClassBuff then
            return GMR.HasBuff(unit, buff, byPlayer)
        end

        for _, buffFromList in ipairs(sameClassBuffList) do
            if GMR.HasBuff(unit, buffFromList, byPlayer) then
                return true
            end
        end

        return false
    end

    ---@class PaladinHolyV2SealSettings
    local PaladinSealSettings = {
        cfgIndex = 0,
        spell = "",
        spellKnown = "",
        buff = "",
    }

    ---@return PaladinHolyV2SealSettings
    function PaladinSealSettings:new(cfgIndex, spell, spellKnown, buff)
        local o = {
            cfgIndex = cfgIndex,
            spell = spell,
            spellKnown = spellKnown,
            buff = buff,
        }
        setmetatable(o, self)
        self.__index = self
        return o
    end

    ---@return table<number,PaladinHolyV2SealSettings> seal settings' config index to PaladinHolyV2SealSettings
    local function compileCfgIndexToSealSettingsMap()
        local tbl = {
            [1] = PaladinSealSettings:new(1, amstlib.CONST.SPELL.sealOfRighteousness, amstlib.CONST.SPELL_KNOWN.sealOfRighteousness, amstlib.CONST.BUFF.sealOfRighteousness),
            [2] = PaladinSealSettings:new(2, amstlib.CONST.SPELL.sealOfJustice, amstlib.CONST.SPELL_KNOWN.sealOfJustice, amstlib.CONST.BUFF.sealOfJustice),
            [3] = PaladinSealSettings:new(3, amstlib.CONST.SPELL.sealOfLight, amstlib.CONST.SPELL_KNOWN.sealOfLight, amstlib.CONST.BUFF.sealOfLight),
            [4] = PaladinSealSettings:new(4, amstlib.CONST.SPELL.sealOfWisdom, amstlib.CONST.SPELL_KNOWN.sealOfWisdom, amstlib.CONST.BUFF.sealOfWisdom),
            [5] = PaladinSealSettings:new(5, amstlib.CONST.SPELL.sealOfCommand, amstlib.CONST.SPELL_KNOWN.sealOfCommand, amstlib.CONST.BUFF.sealOfCommand),
        }

        if GMR.UnitFactionGroup("player") == "Alliance" then
            tbl[6] = PaladinSealSettings:new(6, amstlib.CONST.SPELL.sealOfVengeance, amstlib.CONST.SPELL_KNOWN.sealOfVengeance, amstlib.CONST.BUFF.sealOfVengeance)
        else
            tbl[6] = PaladinSealSettings:new(6, amstlib.CONST.SPELL.sealOfCorruption, amstlib.CONST.SPELL_KNOWN.sealOfCorruption, amstlib.CONST.BUFF.sealOfCorruption)
        end

        return tbl
    end

    ---@class PaladinHolyV2State
    local State = {
        judgmentToUse = amstlib.CONST.SPELL.judgementOfLight,
        judgmentToUseKnown = amstlib.CONST.SPELL_KNOWN.judgementOfLight,
        judgmentToUseDebuff = amstlib.CONST.DEBUFF.judgementOfLight,

        defaultAura = amstlib.CONST.SPELL.devotionAura,

        defaultBlessingSpell = amstlib.CONST.SPELL.blessingOfMight,
        defaultBlessingKnown = amstlib.CONST.SPELL_KNOWN.blessingOfMight,
        defaultBlessingBuff = amstlib.CONST.BUFF.blessingOfMight,

        ---@type PaladinHolyV2SealSettings
        defaultSeal = PaladinSealSettings:new(0, "", false, ""),
        ---@type PaladinHolyV2SealSettings[]
        ignoredSeals = {},

        judgmentCooldown = 10,
    }

    function State:new()
        local o = { }
        setmetatable(o, self)
        self.__index = self
        return o
    end

    ---Determine state
    ---@param cr AmstLibCombatRotation
    ---@param cfg PaladinHolyV2Config config
    ---@return void
    function State:determine(cr, cfg)
        if cfg.useJudgmentType == 2 and amstlib.CONST.SPELL_KNOWN.judgementOfWisdom then
            self.judgmentToUse = amstlib.CONST.SPELL.judgementOfWisdom
            self.judgmentToUseKnown = amstlib.CONST.SPELL_KNOWN.judgementOfWisdom
            self.judgmentToUseDebuff = amstlib.CONST.DEBUFF.judgementOfWisdom
        elseif cfg.useJudgmentType == 3 and amstlib.CONST.SPELL_KNOWN.judgementOfJustice then
            self.judgmentToUse = amstlib.CONST.SPELL.judgementOfJustice
            self.judgmentToUseKnown = amstlib.CONST.SPELL_KNOWN.judgementOfJustice
            self.judgmentToUseDebuff = amstlib.CONST.DEBUFF.judgementOfJustice
        end

        if AmstLibPaladinCommonAuraSettingsMap[cfg.defaultAuraToUse] and AmstLibPaladinCommonAuraSettingsMap[cfg.defaultAuraToUse].spellKnown then
            self.defaultAura = AmstLibPaladinCommonAuraSettingsMap[cfg.defaultAuraToUse].spell
        end

        if cfg.defaultBlessingToUse == 2 and amstlib.CONST.SPELL_KNOWN.blessingOfKings then
            self.defaultBlessingSpell = amstlib.CONST.SPELL.blessingOfKings
            self.defaultBlessingKnown = amstlib.CONST.SPELL_KNOWN.blessingOfKings
            self.defaultBlessingBuff = amstlib.CONST.BUFF.blessingOfKings
        elseif cfg.defaultBlessingToUse == 3 and amstlib.CONST.SPELL_KNOWN.blessingOfWisdom then
            self.defaultBlessingSpell = amstlib.CONST.SPELL.blessingOfWisdom
            self.defaultBlessingKnown = amstlib.CONST.SPELL_KNOWN.blessingOfWisdom
            self.defaultBlessingBuff = amstlib.CONST.BUFF.blessingOfWisdom
        elseif cfg.defaultBlessingToUse == 4 and amstlib.CONST.SPELL_KNOWN.blessingOfSanctuary then
            self.defaultBlessingSpell = amstlib.CONST.SPELL.blessingOfSanctuary
            self.defaultBlessingKnown = amstlib.CONST.SPELL_KNOWN.blessingOfSanctuary
            self.defaultBlessingBuff = amstlib.CONST.BUFF.blessingOfSanctuary
        end

        local cfgIndexToSealSettingsMap = compileCfgIndexToSealSettingsMap()
        if cfgIndexToSealSettingsMap[cfg.defaultSealToUse] and cfgIndexToSealSettingsMap[cfg.defaultSealToUse].spellKnown then
            self.defaultSeal = cfgIndexToSealSettingsMap[cfg.defaultSealToUse]
        end

        for _, sealCfgIndex in ipairs(cfg.defaultSealDoNotSwitchList) do
            if cfgIndexToSealSettingsMap[sealCfgIndex] and cfgIndexToSealSettingsMap[sealCfgIndex].spellKnown then
                table.insert(self.ignoredSeals, cfgIndexToSealSettingsMap[sealCfgIndex])
            end
        end

        self.judgmentCooldown = AmstLibPaladinCommon.CalculateJudgementCdDuration()
        cr:print("judgment cooldown is " .. tostring(self.judgmentCooldown) .. " sec.")
    end

    ---@class PaladinHolyV2Rotation
    local Rotation = {
        ---@type PaladinHolyV2Config
        cfg = nil,
        ---@type PaladinHolyV2State
        state = nil,
        ---@type AmstLibCombatRotation
        cr = nil,
        ---@type AmstLibTrinketer
        trinketer = nil,
        ---@type AmstLibPaladinCommonAuraChanger
        auraChanger = nil,
    }
    ---@param cfg PaladinHolyV2Config
    ---@param state PaladinHolyV2State
    ---@param cr AmstLibCombatRotation
    ---@param trinketer AmstLibTrinketer
    ---@param auraChanger AmstLibPaladinCommonAuraChanger
    ---@return PaladinHolyV2Rotation
    function Rotation:new(cfg, state, cr, trinketer, auraChanger)
        ---@type PaladinHolyV2Rotation
        local o = {
            cfg = cfg,
            state = state,
            cr = cr,
            trinketer = trinketer,
            auraChanger = auraChanger,
        }
        setmetatable(o, self)
        self.__index = self
        return o
    end

    ---@param unit string|userdata
    ---@return boolean Did cleanse
    function Rotation:cleanse(unit)
        if GMR.GetDistance("player", unit, ">", 40) then
            return false
        end
        if not GMR.IsAlive(unit) then
            return false
        end
        if amstlib.CONST.SPELL_KNOWN.cleanse and not GMR.IsCastable(amstlib.CONST.SPELL.cleanse, unit) then
            return false
        elseif amstlib.CONST.SPELL_KNOWN.purify and not GMR.IsCastable(amstlib.CONST.SPELL.purify, unit) then
            return false
        end

        local debuffNameToIndexMap = {}
        for index = 1, 40 do
            local localeName, _, _, debuffType, duration, expireAtTime = GMR.UnitDebuff(unit, index)
            if localeName and expireAtTime - GetTime() < duration - math.random(5, 10) / 10 then
                local isCleanable = false
                if amstlib.CONST.SPELL_KNOWN.cleanse and debuffType == "Disease" or debuffType == "Magic" or debuffType == "Poison" then
                    isCleanable = true
                elseif amstlib.CONST.SPELL_KNOWN.purify and debuffType == "Disease" or debuffType == "Poison" then
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
            if amstlib.CONST.SPELL_KNOWN.cleanse then
                spellSysName = "cleanse"
                spellToCast = amstlib.CONST.SPELL.cleanse
            elseif amstlib.CONST.SPELL_KNOWN.purify then
                spellSysName = "purify"
                spellToCast = amstlib.CONST.SPELL.purify
            end

            self.cr:printDbg("should cast " .. spellSysName .. " on '" .. unit .. "' to remove " .. unknownPart .. "debuff  '" .. localeName .. "':" .. tostring(spellId) .. ".")
            GMR.Cast(amstlib.CONST.SPELL.cleanse, unit)
            return true
        end

        return false
    end

    --- @return number index
    function Rotation:shouldCleanse(unit, debuffNameToIndexMap)
        for debuff, index in pairs(debuffNameToIndexMap) do
            if debuff == amstlib.CONST.DEBUFF.livingBomb and GMR.GetNumPartyMembersAroundUnit(unit, 20) == 0 then
                return index
            end
        end

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

        if not UnitInRaid("player") and not UnitInParty("player") then
            return false
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

    function Rotation:applyBlessingOfFreedom(unit)
        if not self.cfg.useBlessingOfFreedom then
            return false
        end
        if GMR.GetDistance("player", unit, ">", 30) then
            return false
        end
        if not amstlib.CONST.SPELL_KNOWN.blessingOfFreedom or not GMR.IsCastable(amstlib.CONST.SPELL.blessingOfFreedom, unit) then
            return false
        end

        for index = 1, 40 do
            local localeName, _, _, _, duration, expireAtTime, _, _, _, spellId = GMR.UnitDebuff(unit, index)
            if localeName and expireAtTime - GetTime() < duration - math.random(5, 10) / 10 then
                for i, debuffFromRegistry in ipairs(debuffBlessingOfFreedomList) do
                    if debuffFromRegistry == localeName then
                        self.cr:printDbg("should cast blessing of freedom on '" .. unit .. "' to remove debuff  '" ..
                            localeName .. "':" .. tostring(spellId) .. ".")
                        GMR.Cast(amstlib.CONST.SPELL.blessingOfFreedom, unit)
                        return true
                    end
                end
            end
        end
    end

    ---@return boolean did cast something
    function Rotation:executeGroupBuff()
        if not self.cfg.groupBuffModEnabled or GMR.GetMana("player") < self.cfg.groupBuffModMinMana then
            return false
        end

        if not UnitInRaid("player") and not UnitInParty("player") then
            return false
        end

        if UnitInRaid("player") then
            for raidIndex = 1, 40 do
                local unit = "raid" .. tostring(raidIndex)
                if self:buff(unit) then
                    return true
                end
            end
        elseif UnitInParty("player") then
            for partyIndex = 1, 4 do
                local unit = "party" .. tostring(partyIndex)
                if self:buff(unit) then
                    return true
                end
            end
        end

        return false
    end

    ---@return boolean did cast something
    function Rotation:buff(unit)
        if not GMR.IsAlive(unit) then
            return false
        end

        local unitClass = GMR.GetClass(unit)
        local hasBlessingOfMight = HasBuffClassed(unit, amstlib.CONST.BUFF.blessingOfMight)
        local hasBlessingOfKings = HasBuffClassed(unit, amstlib.CONST.BUFF.blessingOfKings)
        local hasBlessingOfMightByPlayer = HasBuffClassed(unit, amstlib.CONST.BUFF.blessingOfMight, true)
        local hasBlessingOfKingsByPlayer = HasBuffClassed(unit, amstlib.CONST.BUFF.blessingOfKings, true)
        if not hasBlessingOfMight and (unitClass == amstlib.CONST.CLASS.ROGUE or unitClass == amstlib.CONST.CLASS.DEATHKNIGHT or unitClass == amstlib.CONST.CLASS.HUNTER or unitClass == amstlib.CONST.CLASS.PALADIN
            or unitClass == amstlib.CONST.CLASS.WARRIOR)
        then
            if GMR.IsCastable(amstlib.CONST.SPELL.blessingOfMight, unit) then
                self.cr:printDbg("should buff '" .. unit .. "' with blessing of might")
                GMR.Cast(amstlib.CONST.SPELL.blessingOfMight, unit)
                return true
            end
        end
        if not hasBlessingOfKings and (unitClass == amstlib.CONST.CLASS.DRUID or unitClass == amstlib.CONST.CLASS.MAGE or unitClass == amstlib.CONST.CLASS.PRIEST
            or unitClass == amstlib.CONST.CLASS.SHAMAN or unitClass == amstlib.CONST.CLASS.WARLOCK)
        then
            if GMR.IsCastable(amstlib.CONST.SPELL.blessingOfKings, unit) then
                self.cr:printDbg("should buff '" .. unit .. "' with blessing of kings")
                GMR.Cast(amstlib.CONST.SPELL.blessingOfKings, unit)
                return true
            end
        end

        if not hasBlessingOfMightByPlayer and not hasBlessingOfKingsByPlayer then
            if not hasBlessingOfKings and GMR.IsCastable(amstlib.CONST.SPELL.blessingOfKings, unit) then
                self.cr:printDbg("should buff '" .. unit .. "' with blessing of kings as additional buff")
                GMR.Cast(amstlib.CONST.SPELL.blessingOfKings, unit)
                return true
            end
        end

        return false
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

        if self.auraChanger:execute() then
            return
        end

        if GMR.IsMoving() and IsMounted("player") then
            return
        end

        local isTargetAttackable = GMR.IsAlive("target") and GMR.UnitCanAttack("player", "target")
            and not GMR.IsImmune("target")

        if not GMR.HasBuff("player", amstlib.CONST.BUFF.righteousFury) and amstlib.CONST.SPELL_KNOWN.righteousFury
            and GMR.IsCastable(amstlib.CONST.SPELL.righteousFury, "player")
        then
            self.cr:printDbg("should cast righteous fury on player to gain tank buff")
            GMR.Cast(amstlib.CONST.SPELL.righteousFury, "player")
            return
        end

        if isTargetAttackable and amstlib.CONST.SPELL_KNOWN.divinePlea
            and not GMR.HasBuff("player", amstlib.CONST.BUFF.divinePlea)
            and GMR.GetDistance("player", "target", "<", 10)
            and GMR.IsCastable(amstlib.CONST.SPELL.divinePlea, "player")
        then
            self.cr:printDbg("should cast divine please to get buff")
            GMR.Cast(amstlib.CONST.SPELL.divinePlea, "player")
            return
        end

        if self.state.defaultBlessingKnown and not HasBuffClassed("player", self.state.defaultBlessingBuff)
            and GMR.IsCastable(self.state.defaultBlessingSpell, "player")
        then
            self.cr:printDbg("should cast default blessing '" .. self.state.defaultBlessingSpell .. "' on player")
            GMR.Cast(self.state.defaultBlessingSpell, "player")
            return
        end

        if self.state.defaultSeal.spellKnown and not GMR.HasBuff("player", self.state.defaultSeal.buff)
            and GMR.IsCastable(self.state.defaultSeal.spell, "player")
        then
            local alreadyHasIgnoredSeal = false
            for _, ignoreSeal in ipairs(self.state.ignoredSeals) do
                if GMR.HasBuff("player", ignoreSeal.buff) then
                    alreadyHasIgnoredSeal = true
                    break
                end
            end
            if not alreadyHasIgnoredSeal then
                self.cr:printDbg("should cast default seal '" .. self.state.defaultSeal.spell .. "' on player")
                GMR.Cast(self.state.defaultSeal.spell, "player")
                return
            end
        end

        if self.cfg.useAggroSpellsInGroup and UnitInParty("player") then
            for partyIndex = 1, 4 do
                local unit = "party" .. tostring(partyIndex)
                for i = 1, #GMR.Tables.Attackables do
                    local attackable = GMR.Tables.Attackables[i][1]
                    if GMR.ObjectExists(attackable) and GMR.IsAlive(attackable) and GMR.UnitLevel(attackable) > 1
                        and GMR.UnitIsUnit(GMR.UnitTarget(attackable), unit)
                    then
                        if amstlib.CONST.SPELL_KNOWN.handOfReckoning and GMR.IsCastable(amstlib.CONST.SPELL.handOfReckoning, attackable)
                        then
                            self.cr:printDbg("should cast hand of reckoning on '" .. GMR.UnitName(attackable) .. "' to taunt")
                            GMR.Cast(amstlib.CONST.SPELL.handOfReckoning, attackable)
                            return
                        elseif amstlib.CONST.SPELL_KNOWN.righteousDefense and GMR.IsCastable(amstlib.CONST.SPELL.righteousDefense, unit) then
                            self.cr:printDbg("should cast righteous defense on '" .. GMR.UnitName(unit) .. "' party member to taunt mobs from")
                            GMR.Cast(amstlib.CONST.SPELL.righteousDefense, unit)
                            return
                        end
                    end
                end
            end
        end

        -- Hammer of Wrath
        if amstlib.CONST.SPELL_KNOWN.hammerOfWrath then
            for i = 1, #GMR.Tables.Attackables do
                local attackable = GMR.Tables.Attackables[i][1]
                if GMR.ObjectExists(attackable) and GMR.IsAlive(attackable) and GMR.GetHealth(attackable) < 20
                    and GMR.UnitLevel(attackable) > 1
                    and GMR.IsCastable(amstlib.CONST.SPELL.hammerOfWrath, attackable)
                then
                    self.cr:printDbg("should cast hammer of wrath")
                    GMR.Cast(amstlib.CONST.SPELL.hammerOfWrath, attackable)
                    return
                end
            end
        end

        if amstlib.CONST.SPELL_KNOWN.holyShield and not GMR.HasBuff("player", amstlib.CONST.BUFF.holyShield)
            and GMR.IsCastable(amstlib.CONST.SPELL.holyShield, "player")
        then
            self.cr:printDbg("should cast holy shield to protect myself'")
            GMR.Cast(amstlib.CONST.SPELL.holyShield, "player")
            return
        end

        -- Judgement
        if self.state.judgmentToUseKnown and GetSpellCooldown(self.state.judgmentToUse) == 0 and isTargetAttackable then
            if not self.cfg.useJudgmentForDebuffOnly or (self.cfg.useJudgmentForDebuffOnly
                and not GMR.HasBuff("target", self.state.judgmentToUseDebuff, true))
            then
                local unitToCast = "target"
                if self.cfg.useJudgmentTryToCleave then
                    for i = 1, #GMR.Tables.Attackables do
                        local attackable = GMR.Tables.Attackables[i][1]
                        if GMR.ObjectExists(attackable) and GMR.IsCastable(self.state.judgmentToUse, attackable)
                            and GMR.GetDistance("player", attackable, "<", 10)
                            and not GMR.IsImmune(attackable)
                            and GMR.UnitLevel(attackable) > 1
                            and GMR.GetDebuffExpiration(attackable, self.state.judgmentToUseDebuff) < self.state.judgmentCooldown
                        then
                            unitToCast = attackable
                            break
                        end
                    end
                end

                if unitToCast and GMR.IsCastable(self.state.judgmentToUse, unitToCast) then
                    self.cr:printDbg("should cast default judgment '" .. self.state.judgmentToUse .. "'")
                    GMR.Cast(self.state.judgmentToUse, unitToCast)
                    return
                end
            end
        end

        if self:cleanse("player") then
            return
        end

        if self:applyBlessingOfFreedom("player") then
            return
        end

        if self:executeGroupCleanse() then
            return
        end

        if isTargetAttackable and self.cfg.useHandOfReckoningToMakeDamage and amstlib.CONST.SPELL_KNOWN.handOfReckoning
            and (self.cfg.useHandOfReckoningInInstance or (not self.cfg.useHandOfReckoningInInstance and not IsInInstance()))
            and not GMR.UnitIsPlayer("target") and not GMR.UnitIsUnit("targettarget", "player")
            and GMR.IsCastable(amstlib.CONST.SPELL.handOfReckoning, "target")
        then
            self.cr:printDbg("should cast hand of reckoning to make some damage")
            GMR.Cast(amstlib.CONST.SPELL.handOfReckoning, "target")
            return
        end

        if isTargetAttackable and amstlib.CONST.SPELL_KNOWN.hammerOfTheRighteous
            and GMR.IsCastable(amstlib.CONST.SPELL.hammerOfTheRighteous, "target")
        then
            self.cr:printDbg("should cast hammer of the righteous")
            GMR.Cast(amstlib.CONST.SPELL.hammerOfTheRighteous, "target")
            return
        end

        if isTargetAttackable and amstlib.CONST.SPELL_KNOWN.shieldOfRighteousness
            and GMR.IsCastable(amstlib.CONST.SPELL.shieldOfRighteousness, "target")
        then
            self.cr:printDbg("should cast shield of righteousness")
            GMR.Cast(amstlib.CONST.SPELL.shieldOfRighteousness, "target")
            return
        end

        if self.cfg.useConsecrations and amstlib.CONST.SPELL_KNOWN.consecrations and not GMR.IsMoving()
            and GMR.GetNumEnemies("player", 10) >= self.cfg.useConsecrationsMinEnemies
            and GMR.IsCastable(amstlib.CONST.SPELL.consecrations, "player")
        then
            self.cr:printDbg("should use consecrations")
            GMR.Cast(amstlib.CONST.SPELL.consecrations, "player")
            return
        end

        if self:executeGroupBuff() then
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
            local mainFunc = function()
                cr:initialize(
                    VERSION,
                    function()
                        local talentTabToCountMap = amstlib.Util.calculateTalentsPerTab()
                        return GMR.GetClass("player") == amstlib.CONST.CLASS.PALADIN and talentTabToCountMap[2] > 30
                    end,
                    function()
                        local cfg = Config:new(cr)
                        cfg:apply(cr:getConfig())

                        local state = State:new()
                        state:determine(cr, cfg)

                        if cfg.groupCleanseModEnabled and cfg.useCombatRotationLauncher then
                            cr:print("You have turned on `groupCleanseModEnabled`;therefore, you should turn off `useCombatRotationLauncher` to get better results")
                        end

                        local trinketer = AmstLibTrinketer:new(cr)
                        --trinketer:initialize(amstlib.CONST.SPELL.chainsOfIce) TODO: determine proper spell to gcd check, of find another way

                        local auraChanger = AmstLibPaladinCommonAuraChanger:new(cr, cfg.useCrusaderAuraWhileMounted,
                            cfg.useCrusaderAuraWhileMounterMinDistance,
                            state.defaultAura,
                            cfg.defaultAuraChangeIfAlreadyExist)
                        local rotation = Rotation:new(cfg, state, cr, trinketer, auraChanger)
                        return function()
                            rotation:execute()
                        end,
                        function()
                            C_Timer.NewTicker(0.5, function()
                                auraChanger:execute()
                            end)
                        end
                    end
                )
            end

            if cr:getConfig()["onlineLoad"] then
                cr:load("blablablabl", mainFunc)
            else
                mainFunc()
            end
        end)
        if not ok then
            GMR.Print("[" .. ID .. "|" .. VERSION .. "]" .. "[ERROR] " .. err)
        end
    end
end)
if not ok then
    GMR.Print("ERROR " .. err)
end