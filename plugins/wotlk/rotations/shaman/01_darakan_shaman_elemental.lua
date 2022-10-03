--This file is part of the AmsTaFFix' GMR plugins/profiles distribution
--(https://github.com/AmsTaFFix/gmr-stuff).
--Copyright (C) 2022 Darakan
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

---@type ShamanConfig
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = false,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = true,
    ---Use online loading feature to get last updates
    onlineLoad = true,
    --- Important: Does not work right now.
    --- Totem Calling id, use 0=none, 1=elements, 2=spirits, 3=ancestors
    useTotemCalling = 0,
    useLesserHealingWaveWhenBelowHp = 30,
    useHealingWaveWhenBelowHp = 50,
    --- if you have glyph for wrath totem, you get a 5min buff. This toggle keeps this active
    useTotemOfWrathForGlyphBuff = true,
}



AMST_SHARE["CR>S/E.CFG"] = Config
if Config.onlineLoad then
    local httpRequester = _G.SendHttpRequestTinkrFix or GMR.SendHttpRequest
    httpRequester({
        Url = "https://raw.githubusercontent.com/darakan1/gmr-stuff/elemental_shaman/plugins/wotlk/rotations/shaman/02_darakan_shaman_elemental_rotation.lua",
        Method = "Get",
        Callback = function(content)
            GMR.RunString(content)
            if AMST_SHARE["CR>S/E.LOADED"] ~= true then
                GMR.Print("[CR>S/E][ERROR] Rotation have not loaded properly!")
                GMR.Print("[CR>S/E][ERROR] Content is: " .. content)
            end
        end
    })
else
    GMR.Print("[CR>S/E] Offline loading turned on")
end