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
local LINK = "https://raw.githubusercontent.com/AmsTaFFix/gmr-stuff/main/plugins/wotlk/rotations/paladin/02_amstaffix_paladin_retri_rotation.lua"
---@type DemonHunterConfig
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = true,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = true,
    ---Use online loading feature to get last updates
    onlineLoad = false,
}

do
    local ok, err = pcall(function()
        local cr = amstlib:getCombatRotation(ID)
        cr:prepare(Config)
        cr:load(LINK)
    end)
    if not ok then
        GMR.Print(ID .. "[ERROR] " .. err)
    end
end