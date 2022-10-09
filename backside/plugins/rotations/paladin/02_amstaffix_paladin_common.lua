local ok, err = pcall(function()
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

end)
if not ok then
    GMR.Print("[ERROR] " .. err)
end