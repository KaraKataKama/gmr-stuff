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

local ID = "CR>P/P"
local LIB_LINK = "https://raw.githubusercontent.com/AmsTaFFix/gmr-stuff/main/backside/plugins/custom/00_amstlib.lua"
local ROTATION_LINK = "TODO"
---@type PaladinProtectionV2Config
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = true,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = true,
    ---Use online loading feature to get last updates
    onlineLoad = false,

    consumeArtOfWarFlashLightMinHp = 80,
    consumeArtOfWarFlashLightIfAuraDepletedSoon = true,

    useConsecrations = true,
    useConsecrationsMinEnemies = 2,
    useDivineStormMinEnemies = 2,

    groupCleanseModEnabled = false,
    useJudgmentType = 1, -- 1:Judgement of Light; 2:Judgement of Wisdom; 3:Judgement of Justice;
    useJudgmentTryToCleave = true,
    useJudgmentForDebuffOnly = false,
    useJudgmentCooldown = 10,

    useHandOfReckoningToMakeDamage = true,
    useHandOfReckoningInInstance = false,

    defaultAuraToUse = 2, -- 1:Devotion Aura; 2:Retribution Aura; 3:Concentration Aura; 4:Shadow Resistance Aura; 5:Frost Resistance Aura; 6:Fire Resistance Aura
    defaultAuraChangeIfAlreadyExist = { 1, 3 }, -- 1:Devotion Aura; 2:Retribution Aura; 3:Concentration Aura; 4:Shadow Resistance Aura; 5:Frost Resistance Aura; 6:Fire Resistance Aura
    defaultBlessingToUse = 1, -- 1:Blessing of Might; 2:Blessing of Kings; 3:Blessing of Wisdom
    defaultSealToUse = 1, -- 1:Seal of Righteousness; 2:Seal of Justice; 3:Seal of Light; 4:Seal of Wisdom; 5:Seal of Command; 6:Seal of Corruption;
    defaultSealDoNotSwitchList = { 6 }, -- 1:Seal of Righteousness; 2:Seal of Justice; 3:Seal of Light; 4:Seal of Wisdom; 5:Seal of Command; 6:Seal of Corruption;

    useCrusaderAuraWhileMounted = true,
    useCrusaderAuraWhileMounterMinDistance = -1,

    useBlessingOfFreedom = true,

    groupBuffModEnabled = false,
    groupBuffModMinMana = 70,

    useDivineProtectionMinHP = 70,
    useHandOfProtectionMinHP = 40,

    healModEnabled = false,
    healModHolyLightHealAmount = 3200,
    healModFlashOfLightHealAmount = 820,
    healModHolyShockHealAmount = 1800,

    useTrinket1 = false,
    useTrinket1Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful

    useTrinket2 = false,
    useTrinket2Type = 1, -- 1:self-buff, 2:target-harmful, 3:aoe-harmful
}

do
    local msgPrefix = "[" .. ID .. "] "
    if Config.onlineLoad then
        GMR.SendHttpRequest({
            Url = LIB_LINK,
            Method = "Get",
            Callback = function(content)
                RunScript(content)
                if not amstlib then
                    GMR.Print(msgPrefix .. "AmsTaFFix' Lib do not initialized properly")
                    return
                end

                local cr = amstlib:getCombatRotation(ID)
                cr:prepare(Config)
                cr:load(ROTATION_LINK)
            end
        })
    else
        GMR.Print(msgPrefix .. "Offline loading of rotation initiated")
        if amstlib then
            local cr = amstlib:getCombatRotation(ID)
            cr:prepare(Config)
            if Config.onlineLoad then
                cr:load(ROTATION_LINK)
            end
        else
            GMR.Print(msgPrefix .. "AmsTaFFix' Lib do not initialized properly")
        end
    end
end