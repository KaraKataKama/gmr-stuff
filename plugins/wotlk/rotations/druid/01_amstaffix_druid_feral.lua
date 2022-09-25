local ID = "CR>D/F"
---@type DruidConfig
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
        cr:load("https://raw.githubusercontent.com/AmsTaFFix/gmr-stuff/main/plugins/wotlk/rotations/paladin/02_amstaffix_paladin_retri_rotation.lua")
    end)
    if not ok then
        GMR.Print(ID .. "[ERROR] " .. err)
    end
end