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

AMST_SHARE = AMST_SHARE or {}

---@type PaladinConfig
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = false,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = true,
    ---Use online loading feature to get last updates
    onlineLoad = true,
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
    defaultAuraChangeIfAlreadyExist = {1,3}, -- 1:Devotion Aura; 2:Retribution Aura; 3:Concentration Aura; 4:Shadow Resistance Aura; 5:Frost Resistance Aura; 6:Fire Resistance Aura
    defaultBlessingToUse = 1, -- 1:Blessing of Might; 2:Blessing of Kings; 3:Blessing of Wisdom
    defaultSealToUse = 1, -- 1:Seal of Righteousness; 2:Seal of Justice; 3:Seal of Light; 4:Seal of Wisdom; 5:Seal of Command; 6:Seal of Corruption;
    defaultSealDoNotSwitchList = {6}, -- 1:Seal of Righteousness; 2:Seal of Justice; 3:Seal of Light; 4:Seal of Wisdom; 5:Seal of Command; 6:Seal of Corruption;

    useCrusaderAuraWhileMounted = true,
    useCrusaderAuraWhileMounterMinDistance = 50,

    useBlessingOfFreedom = true,

    groupBuffModEnabled = false,
    groupBuffModMinMana = 70,

    useDivineProtectionMinHP = 70,
    useHandOfProtectionMinHP = 40,

    healModEnabled = false,
    healModHolyLightHealAmount = 3200,
    healModFlashOfLightHealAmount = 820,
    healModHolyShockHealAmount = 1800,
}

AMST_SHARE["CR>P/R.CFG"] = Config
if Config.onlineLoad then
    GMR.SendHttpRequest({
        Url = "https://raw.githubusercontent.com/AmsTaFFix/gmr-stuff/main/plugins/wotlk/rotations/paladin/02_amstaffix_paladin_retri_rotation.lua",
        Method = "Get",
        Callback = function(content)
            GMR.RunString(content)
            if AMST_SHARE["CR>P/R.LOADED"] ~= true then
                GMR.Print("[CR>P/R][ERROR] Rotation have not loaded properly!")
                GMT.Print("[CR>P/R][ERROR] Content is: " .. content)
            end
        end
    })
else
    GMR.Print("[CR>P/R] Offline loading turned on")
end
