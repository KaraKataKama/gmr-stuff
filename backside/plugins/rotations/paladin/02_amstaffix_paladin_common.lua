local ok, err = pcall(function()
    AmstLibPaladinCommon = {}
    function AmstLibPaladinCommon.CalculateJudgementCdDuration()
        local pointsInImprovedJudgement = select(5, GetTalentInfo(3, 10))
        return 10 - pointsInImprovedJudgement
    end
    ---@class AmstLibPaladinCommonAuraSettings
    AmstLibPaladinCommonAuraSettings = {
        cfgIndex = 0,
        spell = "",
        spellKnown = "",
        buff = "",
    }

    ---@return AmstLibPaladinCommonAuraSettings
    function AmstLibPaladinCommonAuraSettings:new(cfgIndex, spell, spellKnown, buff)
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

    ---@type table<number, AmstLibPaladinCommonAuraSettings>
    AmstLibPaladinCommonAuraSettingsMap = {
        [1] = AmstLibPaladinCommonAuraSettings:new(1, amstlib.CONST.SPELL.devotionAura, amstlib.CONST.SPELL_KNOWN.devotionAura, amstlib.CONST.BUFF.devotionAura),
        [2] = AmstLibPaladinCommonAuraSettings:new(2, amstlib.CONST.SPELL.retributionAura, amstlib.CONST.SPELL_KNOWN.retributionAura, amstlib.CONST.BUFF.retributionAura),
        [3] = AmstLibPaladinCommonAuraSettings:new(3, amstlib.CONST.SPELL.concentrationAura, amstlib.CONST.SPELL_KNOWN.concentrationAura, amstlib.CONST.BUFF.concentrationAura),
        [4] = AmstLibPaladinCommonAuraSettings:new(4, amstlib.CONST.SPELL.shadowResistanceAura, amstlib.CONST.SPELL_KNOWN.shadowResistanceAura, amstlib.CONST.BUFF.shadowResistanceAura),
        [5] = AmstLibPaladinCommonAuraSettings:new(5, amstlib.CONST.SPELL.frostResistanceAura, amstlib.CONST.SPELL_KNOWN.frostResistanceAura, amstlib.CONST.BUFF.frostResistanceAura),
        [6] = AmstLibPaladinCommonAuraSettings:new(6, amstlib.CONST.SPELL.fireResistanceAura, amstlib.CONST.SPELL_KNOWN.fireResistanceAura, amstlib.CONST.BUFF.fireResistanceAura)
    }

    ---@class AmstLibPaladinCommonAuraChanger
    AmstLibPaladinCommonAuraChanger = {}
    ---@type AmstLibCombatRotation
    AmstLibPaladinCommonAuraChanger.cr = nil
    ---@type boolean
    AmstLibPaladinCommonAuraChanger.useCrusaderAuraWhileMounted = false
    ---@type number
    AmstLibPaladinCommonAuraChanger.useCrusaderAuraWhileMounterMinDistance = 100000
    ---@type string
    AmstLibPaladinCommonAuraChanger.defaultAura = ""
    ---@type table
    AmstLibPaladinCommonAuraChanger.defaultAuraAlternatives = {}

    ---@param cr AmstLibCombatRotation
    ---@return AmstLibPaladinCommonAuraChanger
    function AmstLibPaladinCommonAuraChanger:new(cr, useCrusaderAuraWhileMounted, useCrusaderAuraWhileMounterMinDistance,
                                                 defaultAura, defaultAuraAlternatives)
        if defaultAura == "" then
            error("default aura can not be empty!")
        end

        local o = {
            cr = cr,
            useCrusaderAuraWhileMounted = useCrusaderAuraWhileMounted,
            useCrusaderAuraWhileMounterMinDistance = useCrusaderAuraWhileMounterMinDistance,
            defaultAura = defaultAura,
            defaultAuraAlternatives = defaultAuraAlternatives,
        }
        setmetatable(o, self)
        self.__index = self
        return o
    end

    function AmstLibPaladinCommonAuraChanger:execute()
        if self.useCrusaderAuraWhileMounted and amstlib.CONST.SPELL_KNOWN.crusaderAura and IsMounted("player") then
            if not GMR.HasBuff("player", amstlib.CONST.SPELL.crusaderAura)
                and GMR.GetDestinationDistance() > self.useCrusaderAuraWhileMounterMinDistance
                and GMR.IsCastable(amstlib.CONST.SPELL.crusaderAura, "player")
            then
                self.cr:printDbg("should change aura to crusader")
                GMR.Cast(amstlib.CONST.SPELL.crusaderAura, "player")
                return true
            end

            -- should do nothing while mounted
            return false
        end

        if not GMR.HasBuff("player", self.defaultAura) and GMR.IsCastable(self.defaultAura, "player") then
            self.cr:printDbg("should change aura to default '" .. self.defaultAura .. "'")
            GMR.Cast(self.defaultAura, "player")
            return true
        end

        if not GMR.HasBuff("player", self.defaultAura, true) then
            for _, cfgIndex in ipairs(self.defaultAuraAlternatives) do
                local auraSettings = AmstLibPaladinCommonAuraSettingsMap[cfgIndex]
                if auraSettings and auraSettings.spellKnown then
                    if GMR.HasBuff("player", auraSettings.buff) then
                        if GMR.HasBuff("player", auraSettings.buff, true) then
                            -- it's mine aura, no check further
                            break
                        end
                    else
                        self.cr:printDbg("should cast alternative aura with index #" .. tostring(cfgIndex) .. ", '" .. auraSettings.spell .. "'")
                        GMR.Cast(auraSettings.spell, "player")
                        return true
                    end
                end
            end
        end

        return false
    end

    ---@class AmstLibPaladinCommonHealer
    AmstLibPaladinCommonHealer = {}
    ---@type AmstLibCombatRotation
    AmstLibPaladinCommonHealer.cr = nil
    AmstLibPaladinCommonHealer.isEnabled = false
    AmstLibPaladinCommonHealer.holyShockHealAmount = 1
    AmstLibPaladinCommonHealer.flashOfLightHealAmount = 1
    AmstLibPaladinCommonHealer.holyLightHealAmount = 1

    ---@param cr AmstLibCombatRotation
    ---@return AmstLibPaladinCommonHealer
    function AmstLibPaladinCommonHealer:new(cr, isEnabled, holyShockHealAmount, flashOfLightHealAmount, holyLightHealAmount)
        local o = {
            cr = cr,
            isEnabled = isEnabled,
            holyShockHealAmount = holyShockHealAmount,
            flashOfLightHealAmount = flashOfLightHealAmount,
            holyLightHealAmount = holyLightHealAmount,
        }
        setmetatable(o, self)
        self.__index = self
        return o
    end

    function AmstLibPaladinCommonHealer:execute()
        if not self.isEnabled then
            return false
        end

        if not UnitInRaid("player") and not UnitInParty("player") then
            return false
        end

        if self:heal("player") then
            return true
        end

        if UnitHealth("focus") > 0 then
            if self:heal("focus") then
                return true
            end
        end

        if GMR.GetMana("player") < 20 then
            return false
        end

        if UnitInRaid("player") then
            for raidIndex = 1, 40 do
                local unit = "raid" .. tostring(raidIndex)
                if self:heal(unit) then
                    return true
                end
            end
        elseif UnitInParty("player") then
            for partyIndex = 1, 4 do
                local unit = "party" .. tostring(partyIndex)
                if self:heal(unit) then
                    return true
                end
            end
        end

        return false
    end

    function AmstLibPaladinCommonHealer:heal(unit)
        if GMR.GetDistance("player", unit, ">", 40) then
            return false
        end
        if not GMR.IsAlive(unit) then
            return false
        end

        local missingHealth = GMR.UnitHealthMax(unit) - GMR.UnitHealth(unit)
        if GMR.IsMoving() then
            if missingHealth >= self.holyShockHealAmount and GMR.IsCastable(amstlib.CONST.SPELL.holyShock, unit) then
                self.cr:printDbg("should cast holy shock on '" .. unit .. "' to heal while moving")
                GMR.Cast(amstlib.CONST.SPELL.holyShock, unit)
                return true
            elseif missingHealth >= (self.flashOfLightHealAmount * 1.5) -- crit 100%
                and GMR.HasBuff("player", amstlib.CONST.BUFF.infusionOfLight)
                and GMR.IsCastable(amstlib.CONST.SPELL.flashOfLight, unit)
            then
                self.cr:printDbg("should cast flash of light on " .. unit .. " to heal with 'infusion of light' buff while moving")
                GMR.Cast(amstlib.CONST.SPELL.flashOfLight, unit)
                return true
            end
        else
            if missingHealth >= self.holyShockHealAmount and GMR.IsCastable(amstlib.CONST.SPELL.holyShock, unit) then
                self.cr:printDbg("should cast holy shock on " .. unit .. " while standing")
                GMR.Cast(amstlib.CONST.SPELL.holyShock, unit)
                return true
            elseif missingHealth * 1.2 >= self.holyLightHealAmount and GMR.IsCastable(amstlib.CONST.SPELL.holyLight, unit) then
                self.cr:printDbg("should cast holy light on " .. unit .. " while standing")
                GMR.Cast(amstlib.CONST.SPELL.holyLight, unit)
                return true
            elseif false and missingHealth >= self.flashOfLightHealAmount and GMR.IsCastable(amstlib.CONST.SPELL.flashOfLight, unit) then
                self.cr:printDbg("should cast flash of light on " .. unit .. " while standing")
                GMR.Cast(amstlib.CONST.SPELL.flashOfLight, unit)
                return true
            end
        end

        return false
    end
end)
if not ok then
    GMR.Print("[ERROR] " .. err)
end